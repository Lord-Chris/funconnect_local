import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:funconnect/features/places/presentation/widgets/home_categories_large_widget.dart';
import 'package:funconnect/shared/components/_components.dart';
import 'package:funconnect/shared/constants/_constants.dart';

import '../widgets/explore_section.dart';
import '../widgets/home_categories_small_widget.dart';
import '../widgets/home_categories_widget.dart';

class ExploreView extends StatelessWidget {
  const ExploreView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ScrollableColumn(
          crossAxisAlignment: CrossAxisAlignment.start,
          padding: REdgeInsets.symmetric(horizontal: 16),
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    textCapitalization: TextCapitalization.sentences,
                    maxLines: 1,
                    style: AppTextStyles.regular14,
                    decoration: InputDecoration(
                      contentPadding: REdgeInsets.fromLTRB(16, 19, 16, 19),
                      hintText: "Search places, people",
                      filled: true,
                      fillColor: AppColors.exploreIconAsh,
                      prefixIcon: const Icon(
                        Icons.search,
                        size: 20,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(39),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(39),
                      ),
                    ),
                  ),
                ),
                Spacing.horizSmall(),
                InkWell(
                  child: CircleAvatar(
                    radius: 27.r,
                    backgroundColor: AppColors.exploreIconAsh,
                    child: Icon(
                      Icons.filter_list_rounded,
                      size: 20.sp,
                    ),
                  ),
                ),
              ],
            ),
            Spacing.vertExtraMedium(),
            Text(
              "Explore",
              style: AppTextStyles.medium28,
            ),
            Spacing.vertTiny(),
            Text(
              "Explore places near you",
              style: AppTextStyles.regular16,
            ),
            Spacing.vertMedium(),
            SizedBox(
              height: 317.h,
              child: Row(
                children: [
                  const Expanded(
                    flex: 5,
                    child: HomeCategoriesLargeWidget(
                      size: Size.infinite,
                    ),
                  ),
                  Spacing.horizSmall(),
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        const Expanded(
                          child: AppNetworkImage(
                            url: AppConstants.mockImage,
                            borderRadius: 18,
                            fit: BoxFit.cover,
                            size: Size.infinite,
                          ),
                        ),
                        Spacing.vertSmall(),
                        const Expanded(
                          child: AppNetworkImage(
                            url: AppConstants.mockImage,
                            borderRadius: 18,
                            fit: BoxFit.cover,
                            size: Size.infinite,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Spacing.vertMedium(),
            SizedBox(
              height: 45.h,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(vertical: 8.h),
                itemCount: 10,
                itemBuilder: (context, index) {
                  // final interest = state.interests[index];
                  return Padding(
                    padding: EdgeInsets.only(left: 5.r),
                    child: const ExploreSection(
                      section: "Categories",
                      isSelected: false,
                    ),
                  );
                },
              ),
            ),
            Spacing.vertMedium(),
            HomeViewCategoriesWidget(
              itemHeight: 136.r,
              child: const HomeViewCategoriesSmallSubWidget(),
            ),
            Spacing.vertRegular(),
            HomeViewCategoriesWidget(
              label: "Share moments",
              itemHeight: 136.r,
              child: const HomeViewCategoriesSmallSubWidget(),
            ),
            Spacing.vertRegular(),
            HomeViewCategoriesWidget(
              label: "Feel refreshed",
              itemHeight: 136.r,
              child: const HomeViewCategoriesSmallSubWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
