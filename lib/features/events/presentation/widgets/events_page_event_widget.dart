import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:funconnect/features/events/domain/entities/event_model.dart';
import 'package:funconnect/features/events/presentation/blocs/events_bloc/events_bloc.dart';
import 'package:funconnect/shared/components/app_network_image.dart';
import 'package:funconnect/shared/constants/app_constants.dart';

import '../../../../core/presentation/widgets/core_widgets.dart';
import '../../../../shared/constants/colors.dart';
import '../../../../shared/constants/textstyles.dart';
import '../blocs/events_bloc/events_event.dart';

class EventsPageEventWidget extends StatelessWidget {
  final EventModel event;

  const EventsPageEventWidget({
    Key? key,
    required this.event,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.0.h),
      child: InkWell(
        onTap: () =>
            context.read<EventsBloc>().add(EventClickedEvent(event: event)),
        child: Container(
          height: 200.0.h,
          decoration: BoxDecoration(
            color: AppColors.homeViewDrawerAsh,
            borderRadius: BorderRadius.circular(20.0.r),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0.h, horizontal: 8.0.w),
            child: Row(
              children: [
                AppNetworkImage(
                  url: AppConstants.mockImage,
                  borderRadius: 15,
                  fit: BoxFit.cover,
                  size: Size.fromWidth(165.w),
                ),
                Spacing.horizRegular(),
                const VerticalDivider(
                  color: AppColors.exploreIconAsh,
                  thickness: 1.0,
                ),
                Spacing.horizRegular(),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${event.date} - ${event.time}",
                        style: AppTextStyles.regular12.copyWith(
                          color: AppColors.eventTextRed,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              event.title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyles.medium16.copyWith(
                                height: 1,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.bookmark_border,
                              color: AppColors.white,
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Text(
                          event.description,
                          style: AppTextStyles.regular12.copyWith(
                            color: AppColors.locationIconAsh,
                          ),
                        ),
                      ),
                      Spacing.vertRegular(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            event.type.toUpperCase(),
                            style: AppTextStyles.medium20.copyWith(
                              color: AppColors.locationIconAsh,
                            ),
                          ),
                          Spacing.horizRegular(),
                          if (double.tryParse(event.price) == null)
                            Text(
                              "Free",
                              style: AppTextStyles.regular14.copyWith(
                                color: AppColors.primary,
                              ),
                            ),
                        ],
                      ),
                      Spacing.vertTiny(),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
