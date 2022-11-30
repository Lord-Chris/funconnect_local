import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/presentation/widgets/core_widgets.dart';
import '../../../../../shared/constants/app_textStyle.dart';
import '../../../../../shared/constants/colors.dart';
import '../../../../../shared/dumb_widgets/dumb_app_strings.dart';

class EventsPageEventWidget extends StatelessWidget {
  bool isPublic;
  EventsPageEventWidget({
    required this.isPublic,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.0.h),
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
              Container(
                width: 165.0.w,
                decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(19.0.r)),
              ),
              AppSpacer.xtraWeightSpace,
              const VerticalDivider(
                color: AppColors.exploreIconAsh,
                thickness: 1.0,
              ),
              AppSpacer.xtraWeightSpace,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    DumbAppStrings.eventDateText,
                    style: AppTextStyle.WhiteMedium.copyWith(
                        color: AppColors.eventTextRed, fontSize: 15.0.sp),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        DumbAppStrings.eventTitleText,
                        style: AppTextStyle.WhiteBold.copyWith(fontSize: 16.0),
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
                  Text(
                    DumbAppStrings.eventAddressText,
                    style: AppTextStyle.Whitelight.copyWith(
                        color: AppColors.locationIconAsh, fontSize: 15.0.sp),
                  ),
                  AppSpacer.xtraHeightSpace,
                  isPublic
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 32.0.h,
                              decoration: BoxDecoration(
                                color: AppColors.exploreIconAsh,
                                borderRadius: BorderRadius.circular(10.0.r),
                              ),
                              child: Center(
                                child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 16.0.w),
                                  child: Text(
                                    AppText.aTEventPublicText,
                                    style: AppTextStyle.WhiteMedium.copyWith(
                                        color: AppColors.locationIconAsh),
                                  ),
                                ),
                              ),
                            ),
                            AppSpacer.normalWeightSpace,
                            Text(
                              AppText.aTEventFreeText,
                              style: AppTextStyle.WhiteMedium.copyWith(
                                  color: AppColors.primary),
                            ),
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 32.0.h,
                              decoration: BoxDecoration(
                                color: AppColors.exploreIconAsh,
                                borderRadius: BorderRadius.circular(10.0.r),
                              ),
                              child: Center(
                                child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 16.0.w),
                                  child: Text(
                                    AppText.aTEventPrivateText,
                                    style: AppTextStyle.WhiteMedium.copyWith(
                                        color: AppColors.locationIconAsh),
                                  ),
                                ),
                              ),
                            ),
                            // AppSpacer.normalWeightSpace,
                            // Text(
                            //   "Free",
                            //   style: AppTextStyle.WhiteMedium.copyWith(
                            //       color: AppColors.primary),
                            // ),
                          ],
                        )
                ],
              )
              //Sat, Nov 17 - 10:00 AM
            ],
          ),
        ),
      ),
    );
  }
}
