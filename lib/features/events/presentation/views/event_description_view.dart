import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:funconnect/core/presentation/widgets/app_spacer.dart';
import 'package:funconnect/shared/components/app_network_image.dart';
import 'package:funconnect/shared/components/custom_button.dart';
import 'package:funconnect/shared/components/scrollable_column.dart';
import 'package:funconnect/shared/constants/_constants.dart';
import 'package:funconnect/shared/constants/app_constants.dart';

import '../../../../shared/dumb_widgets/dumb_app_strings.dart';
import '../../../dashboard/presentation/widgets/home_categories_lable_widget.dart';
import '../../../dashboard/presentation/widgets/home_categories_small_widget.dart';

class EventDescriptionView extends StatelessWidget {
  const EventDescriptionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            child: Column(
              children: [
                Expanded(
                  child: ScrollableColumn(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const AppNetworkImage(
                        size: Size.fromHeight(350),
                        url: "AppConstants.mockImage",
                        borderRadius: 20,
                        fit: BoxFit.cover,
                      ),
                      AppSpacer.xtraHeightSpace,
                      Text(
                        "Food is Art (The art of food photography + Street food fair)",
                        style: AppTextStyles.semiBold24,
                      ),
                      AppSpacer.xtraHeightSpace,
                      Row(
                        children: [
                          Container(
                            padding: REdgeInsets.fromLTRB(15, 6, 15, 6),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0.r),
                              border: Border.all(
                                width: 1,
                                color: AppColors.gray333,
                              ),
                            ),
                            child: Text(
                              "Private",
                              style: AppTextStyles.regular14.copyWith(
                                color: AppColors.gray97,
                              ),
                            ),
                          ),
                          AppSpacer.normalWeightSpace,
                          Container(
                            padding: REdgeInsets.fromLTRB(15, 6, 15, 6),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0.r),
                              color: AppColors.primary,
                            ),
                            child: Text(
                              "Free",
                              style: AppTextStyles.regular14.copyWith(
                                color: AppColors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                      AppSpacer.xtraHeightSpace,
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: const AppNetworkImage(
                          url: AppConstants.mockImage,
                          isCircular: true,
                          fit: BoxFit.cover,
                          size: Size.square(36),
                        ),
                        title: Text(
                          DumbAppStrings.eventDescriptionSubText0,
                          style: AppTextStyles.medium16,
                        ),
                        subtitle: Text(
                          DumbAppStrings.eventDescriptionSubText1,
                          style: AppTextStyles.regular14.copyWith(
                            color: AppColors.secondary500,
                          ),
                        ),
                      ),
                      AppSpacer.xtraHeightSpace,
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SvgPicture.asset(
                            AppAssets.calenderSvg,
                            height: 18,
                          ),
                          AppSpacer.normalWeightSpace,
                          AppSpacer.smallWeightSpace,
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Saturday October 15th, 2022",
                                  style: AppTextStyles.regular14,
                                ),
                                AppSpacer.normalHeightSpace,
                                Text(
                                  "11:00 AM (GMT +1)",
                                  style: AppTextStyles.regular14,
                                ),
                                AppSpacer.normalHeightSpace,
                                Text(
                                  "Add to calender",
                                  style: AppTextStyles.semiBold14.copyWith(
                                    color: AppColors.primary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      AppSpacer.xtraHeightSpace,
                      AppSpacer.xtraHeightSpace,
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.location_on,
                            size: 18,
                            color: AppColors.secondary500,
                          ),
                          AppSpacer.normalWeightSpace,
                          AppSpacer.smallWeightSpace,
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Freedom park, Lagos Island",
                                  style: AppTextStyles.regular14,
                                ),
                                AppSpacer.normalHeightSpace,
                                AppSpacer.normalHeightSpace,
                                Text(
                                  "Freedom park, Old hospital road, Lagos Island",
                                  style: AppTextStyles.regular14.copyWith(
                                    color: AppColors.secondary500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      AppSpacer.xtraHeightSpace,
                      AppSpacer.xtraHeightSpace,
                      Text(
                        DumbAppStrings.eventDescriptionAboutText,
                        style: AppTextStyles.medium16,
                      ),
                      AppSpacer.smallHeightSpace,
                      AppSpacer.smallHeightSpace,
                      Text(
                        DumbAppStrings.eventDescriptionAboutDescriptionText,
                        style: AppTextStyles.regular14,
                      ),
                      AppSpacer.xtraHeightSpace,
                      AppSpacer.xtraHeightSpace,
                      Container(
                        height: 300.0.h,
                        width: MediaQuery.of(context).size.width,
                        color: AppColors.secondary800,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const AppNetworkImage(
                              url: AppConstants.mockImage,
                              isCircular: true,
                              fit: BoxFit.cover,
                              size: Size.square(56),
                            ),
                            AppSpacer.xtraHeightSpace,
                            Text(
                              DumbAppStrings.eventDescriptionFirstEventText,
                              style: AppTextStyles.medium24,
                            ),
                            AppSpacer.xtraHeightSpace,
                            Text(
                              DumbAppStrings.eventDescriptionSubText1,
                              style: AppTextStyles.regular16.copyWith(
                                color: AppColors.secondary400,
                              ),
                            ),
                            Text(
                              DumbAppStrings.eventDescriptionRsvpMailText,
                              style: AppTextStyles.medium16.copyWith(
                                color: AppColors.secondary200,
                              ),
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
                Container(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Text(
                        "Free",
                        style: AppTextStyles.regular20.copyWith(
                          color: AppColors.gray1,
                        ),
                      ),
                      AppSpacer.xtraWeightSpace,
                      Expanded(
                        child: AppButton(
                          label: "Request",
                          hasBorder: true,
                          borderColor: AppColors.primary.withOpacity(.4),
                          labelColor: AppColors.primary,
                          labelSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 100,
            child: ClipRect(
              child: Container(
                padding: const EdgeInsets.only(bottom: 5),
                color: AppColors.black.withOpacity(.7),
                alignment: Alignment.bottomCenter,
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 5,
                    sigmaY: 5,
                  ),
                  child: Row(
                    children: [
                      MaterialButton(
                        onPressed: () {},
                        color: AppColors.black.withOpacity(0.5),
                        shape: const CircleBorder(),
                        minWidth: 30,
                        padding: const EdgeInsets.all(5),
                        child: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          size: 15,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "Food is Art",
                          textAlign: TextAlign.center,
                          style: AppTextStyles.semiBold24,
                        ),
                      ),
                      MaterialButton(
                        onPressed: () {},
                        color: AppColors.black.withOpacity(0.5),
                        shape: const CircleBorder(),
                        minWidth: 30,
                        padding: const EdgeInsets.all(5),
                        child: const Icon(
                          Icons.more_vert,
                          size: 17,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
