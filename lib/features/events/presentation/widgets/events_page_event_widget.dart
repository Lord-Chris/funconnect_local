import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:funconnect/core/app/_app.dart';
import 'package:funconnect/features/events/domain/entities/event_model.dart';
import 'package:funconnect/services/_services.dart';
import 'package:funconnect/shared/components/app_network_image.dart';
import 'package:funconnect/shared/constants/app_constants.dart';

import '../../../../core/presentation/widgets/core_widgets.dart';
import '../../../../shared/constants/colors.dart';
import '../../../../shared/constants/textstyles.dart';

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
            locator<INavigationService>().toNamed(Routes.eventDescriptionRoute),
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
                AppSpacer.xtraWeightSpace,
                const VerticalDivider(
                  color: AppColors.exploreIconAsh,
                  thickness: 1.0,
                ),
                AppSpacer.xtraWeightSpace,
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
                      AppSpacer.xtraHeightSpace,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            event.type.toUpperCase(),
                            style: AppTextStyles.whiteMedium
                                .copyWith(color: AppColors.locationIconAsh),
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
