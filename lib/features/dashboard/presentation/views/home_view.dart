import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:funconnect/core/presentation/widgets/app_spacer.dart';
import 'package:funconnect/shared/components/app_network_image.dart';
import 'package:funconnect/shared/constants/_constants.dart';

import '../../../../shared/constants/app_constants.dart';
import '../widgets/home_view_widgets.dart';

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
                      const SizedBox(width: 8),
                      const AppNetworkImage(
                        size: Size.square(50),
                        url: AppConstants.mockImage,
                      ),
                      AppSpacer.xtraWeightSpace,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Hi John",
                            style: AppTextStyles.medium20,
                          ),
                          AppSpacer.normalHeightSpace,
                          Row(
                            children: [
                              const Icon(
                                Icons.location_on,
                                color: AppColors.locationIconAsh,
                                size: 13,
                              ),
                              Text(
                                "Yaba, Lagos",
                                style: AppTextStyles.regular14.copyWith(
                                  color: AppColors.secondary400,
                                ),
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
              const Divider(
                color: AppColors.secondary400,
                height: 1,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: SizedBox(
                  height: 35.h,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(left: 8.0.w),
                        child: const HomeInterestWidget(),
                      );
                    },
                  ),
                ),
              ),
              const Divider(
                color: AppColors.secondary400,
                height: 1,
              ),
              const SizedBox(height: 8),
              HomeViewCategoriesWidget(
                label: "Categories",
                child: const HomeViewCategoriesSmallSubWidget(),
              ),
              AppSpacer.normalHeightSpace,
              HomeViewCategoriesWidget(
                height: 200,
                label: "Best for you",
                child: HomeCategoriesLargeWidget(),
              ),
              AppSpacer.normalHeightSpace,
              HomeViewCategoriesWidget(
                height: 200,
                label: "Recently added",
                child: HomeCategoriesLargeWidget(),
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
