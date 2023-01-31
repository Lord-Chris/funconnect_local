import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:funconnect/shared/components/app_network_image.dart';
import 'package:funconnect/shared/constants/_constants.dart';

import '../widgets/home_categories_large_widget.dart';
import '../widgets/home_categories_small_widget.dart';
import '../widgets/home_categories_widget.dart';
import '../widgets/home_interest_widget.dart';

class HomeView extends HookWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final showAllCategory = useState(false);
    final showAllBest = useState(false);
    final showAllRecents = useState(false);
    return Scaffold(
      backgroundColor: AppColors.black,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SafeArea(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Spacing.horizSmall(),
                      AppNetworkImage(
                        borderRadius: 50.r,
                        isCircular: true,
                        url: AppConstants.mockImage,
                        fit: BoxFit.cover,
                      ),
                      Spacing.horizRegular(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Hi John",
                            style: AppTextStyles.medium20,
                          ),
                          Spacing.vertTiny(),
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
                      CupertinoIcons.bell_fill,
                      color: AppColors.white,
                    ),
                  ),
                ],
              ),
              Spacing.vertSmall(),
              const Divider(
                color: AppColors.secondary500,
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
                        padding: EdgeInsets.only(left: 5.r),
                        child: const HomeInterestWidget(),
                      );
                    },
                  ),
                ),
              ),
              const Divider(
                color: AppColors.secondary500,
                height: 1,
              ),
              const SizedBox(height: 8),
              HomeViewCategoriesWidget(
                label: "Categories",
                itemHeight: 136.r,
                showAll: showAllCategory.value,
                // crossAxisCount: 3,
                onSeeAllTap: (val) => showAllCategory.value = val,
                child: const HomeViewCategoriesSmallSubWidget(),
              ),
              Spacing.vertSmall(),
              HomeViewCategoriesWidget(
                label: "Best for you",
                // crossAxisCount: 2,
                showAll: showAllBest.value,
                onSeeAllTap: (val) => showAllBest.value = val,
                child: const HomeCategoriesLargeWidget(),
              ),
              Spacing.vertSmall(),
              HomeViewCategoriesWidget(
                label: "Recently added",
                // crossAxisCount: 2,
                showAll: showAllRecents.value,
                onSeeAllTap: (val) => showAllRecents.value = val,
                child: const HomeCategoriesLargeWidget(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
