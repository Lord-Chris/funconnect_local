import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:funconnect/features/places/domain/entities/full_place_model.dart';
import 'package:funconnect/features/plans/domain/entities/mini_plan_model.dart';
import 'package:funconnect/features/plans/domain/entities/mini_plan_place_model.dart';
import 'package:funconnect/features/plans/presentation/plan_details/bloc/plan_details_bloc.dart';
import 'package:funconnect/shared/components/app_network_image.dart';
import 'package:funconnect/shared/constants/app_assets.dart';
import 'package:funconnect/shared/constants/colors.dart';
import 'package:intl/intl.dart';

class PlanPlaceItem extends StatelessWidget {
  final FullPlaceModel? place;
  final MiniPlanPlaceModel miniPlanPlace;
  final MiniPlanModel plan;
  const PlanPlaceItem(
      {super.key,
      required this.place,
      required this.miniPlanPlace,
      required this.plan});

  @override
  Widget build(BuildContext context) {
    var dateTime =
        DateFormat("yyyy-MM-dd HH:mm:ss").parse(miniPlanPlace.dateTime, true);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppNetworkImage(
          url: place?.coverImagePath ?? "",
          size: Size(60.w, 60.h),
          borderRadius: 8,
          fit: BoxFit.cover,
          placeholderAssetImage: AppAssets.add,
        ),
        SizedBox(
          width: 8.w,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    place?.name ?? "",
                    style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).colorScheme.onBackground),
                  ),
                  InkWell(
                    onTap: () {
                      context.read<PlanDetailsBloc>().add(PlanPlaceEditEvent(
                          plan: plan, place: miniPlanPlace, fullPlace: place));
                    },
                    child: const Text("Edit",
                        style:
                            TextStyle(fontSize: 14, color: AppColors.primary)),
                  )
                ],
              ),
              SizedBox(
                height: 8.h,
              ),
              Text(
                place?.location?.address ?? "",
                style: TextStyle(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? const Color(0xff999999)
                        : AppColors.secondary500,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 8.h,
              ),
              Text(
                  "${place?.opensAtParsed.format(context)} - ${place?.closesAtParsed.format(context)}",
                  style: TextStyle(
                      color: const Color(0xff999999),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400)),
              SizedBox(
                height: 16.h,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.access_time,
                    size: 30.r,
                    color: const Color(0xff999999),
                  ),
                  SizedBox(
                    width: 8.w,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        DateFormat.jm().format(dateTime.toLocal()),
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.onBackground,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      Text(
                        DateFormat("EEEE dd MMMM, yyyy")
                            .format(dateTime.toLocal()),
                        style: const TextStyle(
                            color: Color(0xff999999),
                            fontWeight: FontWeight.w400),
                      )
                    ],
                  )
                ],
              ),
              Text("The Id ${miniPlanPlace.id}")
            ],
          ),
        )
      ],
    );
  }
}
