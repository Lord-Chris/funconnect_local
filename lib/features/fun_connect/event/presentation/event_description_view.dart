import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:funconnect/core/presentation/widgets/app_spacer.dart';
import 'package:funconnect/shared/constants/_constants.dart';

import '../../../../shared/dumb_widgets/dumb_app_strings.dart';
import '../../../dashboard/widgets/home_categories_lable_widget.dart';
import '../../../dashboard/widgets/home_categories_small_widget.dart';

class EventDescription extends StatelessWidget {
  const EventDescription({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.interestWidgetAsh,
        title: Text(
          DumbAppStrings.eventTitleText,
          style: AppTextStyle.whiteMedium,
        ),
        actions: [
          CircleAvatar(
            backgroundColor: AppColors.black,
            child: IconButton(
              icon: const Icon(
                Icons.menu_open,
                color: AppColors.white,
              ),
              onPressed: () {},
            ),
          ),
          AppSpacer.xtraWeightSpace,
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 250.0.h,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.0.r),
                  bottomRight: Radius.circular(20.0.r),
                ),
              ),
            ),
            AppSpacer.xtraHeightSpace,
            Text(
              DumbAppStrings.eventDescriptionSubTitleText,
              style: AppTextStyle.whiteBold.copyWith(fontSize: 24.0.sp),
            ),
            AppSpacer.xtraHeightSpace,
            Row(
              children: [
                Container(
                  height: 30.0.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0.r),
                    border: Border.all(
                      width: 1,
                      color: AppColors.exploreIconAsh,
                    ),
                  ),
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                      child: Text(
                        DumbAppStrings.eventDescriptionPrivateLAbelText,
                        style: AppTextStyle.blacklight.copyWith(
                          color: AppColors.exploreIconAsh,
                        ),
                      ),
                    ),
                  ),
                ),
                AppSpacer.normalWeightSpace,
                Container(
                  height: 30.0.h,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(10.0.r),
                  ),
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                      child: Text(
                        DumbAppStrings.eventDescriptionFreeLAbelText,
                        style: AppTextStyle.blacklight.copyWith(
                          color: AppColors.exploreIconAsh,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            AppSpacer.xtraHeightSpace,
            ListTile(
              leading: const CircleAvatar(),
              title: Text(
                DumbAppStrings.eventDescriptionSubText0,
                style: AppTextStyle.whiteMedium,
              ),
              subtitle: Text(
                DumbAppStrings.eventDescriptionSubText1,
                style: AppTextStyle.whitelight,
              ),
            ),
            AppSpacer.xtraHeightSpace,
            Row(
              children: [
                const Icon(
                  Icons.calendar_month,
                  color: AppColors.ash,
                ),
                AppSpacer.smallWeightSpace,
                Text(
                  DumbAppStrings.eventDescriptionDateAndTimeText,
                  style: AppTextStyle.whitelight,
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: 35.0.w, top: 8.0.h),
              child: Text(
                DumbAppStrings.eventDescriptionCalenderText,
                style:
                    AppTextStyle.whiteBold.copyWith(color: AppColors.primary),
              ),
            ),
            AppSpacer.xtraHeightSpace,
            Text(
              DumbAppStrings.eventDescriptionAboutText,
              style: AppTextStyle.whiteBold,
            ),
            AppSpacer.smallHeightSpace,
            AppSpacer.smallHeightSpace,
            Text(
              DumbAppStrings.eventDescriptionAboutDescriptionText,
              style: AppTextStyle.whitelight.copyWith(fontSize: 14.0.sp),
            ),
            AppSpacer.xtraHeightSpace,
            AppSpacer.xtraHeightSpace,
            Container(
              height: 300.0.h,
              width: MediaQuery.of(context).size.width,
              color: AppColors.homeViewDrawerAsh,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50.0.r,
                  ),
                  AppSpacer.xtraHeightSpace,
                  Text(
                    DumbAppStrings.eventDescriptionFirstEventText,
                    style: AppTextStyle.whiteBold.copyWith(fontSize: 24.0.sp),
                  ),
                  AppSpacer.xtraHeightSpace,
                  Text(
                    DumbAppStrings.eventDescriptionSubText1,
                    style: AppTextStyle.whiteBold.copyWith(
                        fontSize: 16.0.sp, color: AppColors.emailAddressAsh),
                  ),
                  Text(
                    DumbAppStrings.eventDescriptionRsvpMailText,
                    style: AppTextStyle.whiteBold.copyWith(
                        fontSize: 16.0.sp, color: AppColors.emailAddressAsh),
                  ),
                ],
              ),
            ),
            AppSpacer.xtraHeightSpace,
            AppSpacer.xtraHeightSpace,
            AppSpacer.xtraHeightSpace,
            AppSpacer.xtraHeightSpace,
            HomeViewCategoriesWidget(
              label: DumbAppStrings.eventDescriptionMoreLikeText,
              child: const HomeViewCategoriesSmallSubWidget(),
            ),
            AppSpacer.xtraHeightSpace,
            AppSpacer.xtraHeightSpace,
            AppSpacer.xtraHeightSpace,
            AppSpacer.xtraHeightSpace,
            AppSpacer.xtraHeightSpace,
            AppSpacer.xtraHeightSpace,
          ],
        ),
      ),
    );
  }
}
