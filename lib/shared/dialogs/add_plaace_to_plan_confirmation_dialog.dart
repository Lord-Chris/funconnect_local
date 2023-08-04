import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:funconnect/features/places/domain/entities/full_place_model.dart';
import 'package:funconnect/features/plans/domain/entities/mini_plan_model.dart';
import 'package:funconnect/shared/components/custom_button.dart';

import 'package:funconnect/shared/constants/colors.dart';
import 'package:intl/intl.dart';

class AddPlaceToPlanConfirmation extends StatelessWidget {
  final FullPlaceModel place;
  final List<MiniPlanModel> plans;
  final DateTime selectedDate;
  const AddPlaceToPlanConfirmation(
      {super.key,
      required this.place,
      required this.plans,
      required this.selectedDate});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            color: const Color(0xff161616),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 32.h, horizontal: 16.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Confirmation",
                  style: TextStyle(
                      color: AppColors.gray97,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 19.h,
                ),
                const Divider(
                  color: Color(0xff2c2c2c),
                  thickness: 1,
                ),
                SizedBox(
                  height: 19.h,
                ),
                Text("Place",
                    style: TextStyle(
                        fontSize: 14.sp,
                        color: AppColors.secondary400,
                        fontWeight: FontWeight.w500)),
                SizedBox(
                  height: 16.h,
                ),
                Text(
                  place.name,
                  style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
                SizedBox(
                  height: 8.h,
                ),
                Text(
                  place.location!.address,
                  style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.gray97),
                ),
                SizedBox(
                  height: 19.h,
                ),
                Text("Plan (${plans.length})"),
                SizedBox(
                  height: 16.h,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: plans.length,
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        SizedBox(
                          width: 8.w,
                        ),
                        Text(
                          ".",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18.sp,
                              color: Colors.white),
                        ),
                        SizedBox(
                          width: 8.w,
                        ),
                        Text(plans[index].name,
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 18.sp,
                                color: Colors.white))
                      ],
                    );
                  },
                ),
                SizedBox(
                  height: 19.h,
                ),
                Text(
                  "Date",
                  style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.secondary400),
                ),
                SizedBox(
                  height: 16.h,
                ),
                Text(
                  DateFormat("EEEE d MMMM,y").format(selectedDate),
                  style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
                SizedBox(
                  height: 19.h,
                ),
                Text(
                  "Time",
                  style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.secondary400),
                ),
                SizedBox(
                  height: 16.h,
                ),
                Text(
                  DateFormat.jm().format(selectedDate),
                  style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
                SizedBox(
                  height: 48.h,
                ),
                AppButton(
                  label: "Confirm",
                  borderRadius: 8.r,
                )
              ],
            ),
          )),
    );
  }
}
