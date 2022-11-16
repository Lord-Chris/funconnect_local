import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:funconnect/core/presentation/widgets/app_spacer.dart';
import 'package:funconnect/shared/constants/_constants.dart';

import '../../../../core/presentation/widgets/custom_drawer.dart';
import '../../widgets/home_view_widgets.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 25.0,
                      ),
                      AppSpacer.xtraWeightSpace,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 8.0.w),
                            child: Text(
                              "Hi John",
                              style: AppTextStyle.WhiteBold.copyWith(
                                  fontSize: 24.0.sp),
                            ),
                          ),
                          AppSpacer.normalHeightSpace,
                          Row(
                            children: [
                              const Icon(
                                Icons.location_on,
                                color: AppColors.locationIconAsh,
                              ),
                              Text(
                                "Yaba, Lagos",
                                style: AppTextStyle.Whitelight.copyWith(
                                    color: AppColors.homeViewAsh),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.notification_add_rounded,
                      color: AppColors.white,
                    ),
                  ),
                ],
              ),
              AppSpacer.normalHeightSpace,
              CustomDrawer(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Container(
                  height: 56.0.h,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: EdgeInsets.only(right: 8.0.w),
                          child: const HomeInterestWidget(),
                        );
                      }),
                ),
              ),
              CustomDrawer(),
              HomeViewCategoriesWidget(
                label: "Categories",
                child: const HomeViewCategoriesSmallSubWidget(),
              ),
              AppSpacer.normalHeightSpace,
              HomeViewCategoriesWidget(
                height: 200,
                child: const HomeCategoriesLargeWidget(),
                label: "Best for you",
              ),
              AppSpacer.normalHeightSpace,
              HomeViewCategoriesWidget(
                height: 200,
                label: "Recently added",
                child: const HomeCategoriesLargeWidget(),
              ),
              AppSpacer.xtraHeightSpace,
              AppSpacer.normalHeightSpace,
            ],
          ),
        ),
      ),
    );
  }
}
