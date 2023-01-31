import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:funconnect/shared/constants/_constants.dart';

import '../../../../dashboard/presentation/widgets/home_categories_lable_widget.dart';
import '../../../../dashboard/presentation/widgets/home_categories_small_widget.dart';

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
          style: AppTextStyles.medium24,
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
          Spacing.horizRegular(),
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
            Spacing.vertRegular(),
            Text(
              DumbAppStrings.eventDescriptionSubTitleText,
              style: AppTextStyles.medium24,
            ),
            Spacing.vertRegular(),
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
                        style: AppTextStyles.medium12.copyWith(
                          color: AppColors.exploreIconAsh,
                        ),
                      ),
                    ),
                  ),
                ),
                Spacing.horizSmall(),
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
                        style: AppTextStyles.medium12.copyWith(
                          color: AppColors.exploreIconAsh,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Spacing.vertRegular(),
            ListTile(
              leading: const CircleAvatar(),
              title: Text(
                DumbAppStrings.eventDescriptionSubText0,
                style: AppTextStyles.medium12,
              ),
              subtitle: Text(
                DumbAppStrings.eventDescriptionSubText1,
                style: AppTextStyles.medium12,
              ),
            ),
            Spacing.vertRegular(),
            Row(
              children: [
                const Icon(
                  Icons.calendar_month,
                  color: AppColors.ash,
                ),
                Spacing.horizTiny(),
                Text(
                  DumbAppStrings.eventDescriptionDateAndTimeText,
                  style: AppTextStyles.medium12,
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: 35.0.w, top: 8.0.h),
              child: Text(
                DumbAppStrings.eventDescriptionCalenderText,
                style:
                    AppTextStyles.medium12.copyWith(color: AppColors.primary),
              ),
            ),
            Spacing.vertRegular(),
            Text(
              DumbAppStrings.eventDescriptionAboutText,
              style: AppTextStyles.medium12,
            ),
            Spacing.vertTiny(),
            Spacing.vertTiny(),
            Text(
              DumbAppStrings.eventDescriptionAboutDescriptionText,
              style: AppTextStyles.medium12.copyWith(fontSize: 14.0.sp),
            ),
            Spacing.vertRegular(),
            Spacing.vertRegular(),
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
                  Spacing.vertRegular(),
                  Text(
                    DumbAppStrings.eventDescriptionFirstEventText,
                    style: AppTextStyles.medium12.copyWith(fontSize: 24.0.sp),
                  ),
                  Spacing.vertRegular(),
                  Text(
                    DumbAppStrings.eventDescriptionSubText1,
                    style: AppTextStyles.medium12.copyWith(
                        fontSize: 16.0.sp, color: AppColors.emailAddressAsh),
                  ),
                  Text(
                    DumbAppStrings.eventDescriptionRsvpMailText,
                    style: AppTextStyles.medium12.copyWith(
                        fontSize: 16.0.sp, color: AppColors.emailAddressAsh),
                  ),
                ],
              ),
            ),
            Spacing.vertRegular(),
            Spacing.vertRegular(),
            Spacing.vertRegular(),
            Spacing.vertRegular(),
            HomeViewCategoriesWidget(
              label: DumbAppStrings.eventDescriptionMoreLikeText,
              child: const HomeViewCategoriesSmallSubWidget(),
            ),
            Spacing.vertRegular(),
            Spacing.vertRegular(),
            Spacing.vertRegular(),
            Spacing.vertRegular(),
            Spacing.vertRegular(),
            Spacing.vertRegular(),
          ],
        ),
      ),
    );
  }
}
