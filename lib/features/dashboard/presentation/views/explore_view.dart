import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:funconnect/core/presentation/widgets/core_widgets.dart';
import 'package:funconnect/shared/constants/_constants.dart';

import '../../widgets/home_categories_lable_widget.dart';
import '../../widgets/home_categories_large_widget.dart';
import '../../widgets/home_categories_small_widget.dart';

class ExploreView extends StatelessWidget {
  const ExploreView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  // AppTextForm(onChanged: (String) {}, validator: (_) {}),
                  CircleAvatar(
                    radius: 25.0.r,
                    backgroundColor: AppColors.exploreIconAsh,
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.horizontal_split_sharp,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding:
                    EdgeInsets.only(left: 8.0.w, bottom: 8.0.h, top: 32.0.h),
                child: Text(
                  AppText.aTexplore,
                  style: AppTextStyles.whiteMedium.copyWith(
                    fontSize: 28.0.sp,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 8.0.w, bottom: 32.0.h),
                child: Text(
                  AppText.aTexplorePlaces,
                  style: AppTextStyles.whiteMedium.copyWith(fontSize: 16.0.sp),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: HomeCategoriesLargeWidget(
                        // width: 250.0.w,
                        ),
                  ),
                  AppSpacer.smallWeightSpace,
                  Column(
                    children: [
                      Container(
                        height: 150.0.h,
                        width: 110.0.w,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(20.0.r),
                        ),
                      ),
                      AppSpacer.smallHeightSpace,
                      Container(
                        height: 150.0.h,
                        width: 110.0.w,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(20.0.r),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              AppSpacer.xtraHeightSpace,
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ExploreCategoriesWidgets(
                      label: AppText.aTAll,
                    ),
                    ExploreCategoriesWidgets(
                      label: AppText.aTCategories,
                    ),
                    ExploreCategoriesWidgets(
                      label: AppText.aTMostViewed,
                    ),
                    ExploreCategoriesWidgets(
                      label: AppText.aTBestRatings,
                    ),
                    ExploreCategoriesWidgets(
                      label: AppText.aTRecentlyAdded,
                    ),
                  ],
                ),
              ),
              HomeViewCategoriesWidget(
                label: "",
                child: const HomeViewCategoriesSmallSubWidget(),
              ),
              AppSpacer.xtraHeightSpace,
              HomeViewCategoriesWidget(
                label: AppText.aTShareMoments,
                child: const HomeViewCategoriesSmallSubWidget(),
              ),
              AppSpacer.xtraHeightSpace,
              HomeViewCategoriesWidget(
                label: AppText.aTFeelRefreshed,
                child: const HomeViewCategoriesSmallSubWidget(),
              ),
              AppSpacer.xtraHeightSpace,
            ],
          ),
        ),
      ),
    );
  }
}

class ExploreCategoriesWidgets extends StatefulWidget {
  String label;

  ExploreCategoriesWidgets({
    required this.label,
    Key? key,
  }) : super(key: key);

  @override
  State<ExploreCategoriesWidgets> createState() =>
      _ExploreCategoriesWidgetsState();
}

class _ExploreCategoriesWidgetsState extends State<ExploreCategoriesWidgets> {
  Color color = AppColors.interestWidgetAsh;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 8.0.w),
      child: GestureDetector(
        onTap: () {
          print("Clicked");
          setState(() {
            if (color == AppColors.interestWidgetAsh) {
              color == AppColors.primary;
            } else {
              color == AppColors.interestWidgetAsh;
            }
          });
        },
        child: Container(
          height: 30.0.h,
          //width: 110.0.w,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(15.0.r),
          ),
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0.w),
              child: Text(
                widget.label,
                style: AppTextStyles.whitelight,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
