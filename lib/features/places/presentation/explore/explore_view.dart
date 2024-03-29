import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:funconnect/features/places/presentation/explore/bloc/explore_bloc.dart';
import 'package:funconnect/features/places/presentation/explore/bloc/explore_event.dart';
import 'package:funconnect/features/places/presentation/explore/bloc/explore_state.dart';
import 'package:funconnect/shared/components/_components.dart';
import 'package:funconnect/shared/constants/_constants.dart';

import '../../domain/entities/category_model.dart';
import '../../domain/entities/place_model.dart';
import '../home/widgets/categories_large_widget.dart';
import '../home/widgets/categories_small_widget.dart';
import '../home/widgets/categories_widget.dart';
import '../home/widgets/home_skeleton.dart';

class ExploreView extends StatefulWidget {
  const ExploreView({Key? key}) : super(key: key);

  @override
  State<ExploreView> createState() => _ExploreViewState();
}

class _ExploreViewState extends State<ExploreView> {
  @override
  void initState() {
    super.initState();
    context.read<ExploreBloc>().add(const ExploreInitEvent());
  }

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                Spacing.horizRegular(),
                Expanded(
                  child: GestureDetector(
                    onTap: () => context
                        .read<ExploreBloc>()
                        .add(const SearchBarTapEvent()),
                    child: TextField(
                      textCapitalization: TextCapitalization.sentences,
                      maxLines: 1,
                      style: AppTextStyles.regular14,
                      readOnly: true,
                      decoration: InputDecoration(
                        contentPadding: REdgeInsets.fromLTRB(16, 19, 16, 19),
                        hintText: "Search places, people",
                        filled: true,
                        enabled: false,
                        hintStyle: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.secondary300,
                        ),
                        fillColor: isDarkMode
                            ? AppColors.exploreIconAsh
                            : AppColors.wGreyF8,
                        prefixIcon: const Icon(
                          Icons.search,
                          size: 20,
                          color: AppColors.secondary300,
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: isDarkMode
                                ? AppColors.transparent
                                : AppColors.wGreyE1,
                          ),
                          borderRadius: BorderRadius.circular(39),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(39),
                        ),
                      ),
                    ),
                  ),
                ),
                // Spacing.horizSmall(),
                // InkWell(
                //   child: CircleAvatar(
                //     radius: 27.r,
                //     backgroundColor: AppColors.exploreIconAsh,
                //     child: Icon(
                //       Icons.filter_list_rounded,
                //       size: 20.sp,
                //     ),
                //   ),
                // ),
                Spacing.horizRegular(),
              ],
            ),
            Expanded(
              child: BlocBuilder<ExploreBloc, ExploreState>(
                builder: (context, state) {
                  if (state is ExploreLoadingState) {
                    return const HomeSkeleton();
                  }
                  if (state is ExploreFailureState) {
                    return Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            state.failure.message,
                            style: AppTextStyles.medium14,
                          ),
                          Spacing.vertRegular(),
                          AppButton(
                            label: "Retry",
                            isCollapsed: true,
                            labelColor:
                                Theme.of(context).colorScheme.onBackground,
                            onTap: () => context
                                .read<ExploreBloc>()
                                .add(const ExploreInitEvent()),
                          )
                        ],
                      ),
                    );
                  }
                  if (state is! ExploreIdleState) return const SizedBox();
                  return RefreshIndicator(
                    onRefresh: () async {
                      context
                          .read<ExploreBloc>()
                          .add(const ExploreInitEvent(showLoader: false));
                      await context.read<ExploreBloc>().stream.first;
                    },
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: REdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          //physics: const AlwaysScrollableScrollPhysics(),
                          crossAxisAlignment: CrossAxisAlignment.start,
                          //padding: REdgeInsets.symmetric(horizontal: 16),
                          children: [
                            Spacing.vertSmall(),
                            const FeaturedSection(),
                            // SizedBox(
                            //   height: 45.h,
                            //   width: MediaQuery.of(context).size.width,
                            //   child: ListView.builder(
                            //     scrollDirection: Axis.horizontal,
                            //     padding: EdgeInsets.symmetric(vertical: 8.h),
                            //     itemCount: 10,
                            //     itemBuilder: (context, index) {
                            //       // final interest = state.interests[index];
                            //       return Padding(
                            //         padding: EdgeInsets.only(left: 5.r),
                            //         child: const ExploreSection(
                            //           section: "Categories",
                            //           isSelected: false,
                            //         ),
                            //       );
                            //     },
                            //   ),
                            // ),
                            // Spacing.vertRegular(),
                            if (state.categories.isNotEmpty)
                              HomeSection<CategoryModel>(
                                label: "Categories",
                                itemHeight: 136.r,
                                showSeeAll: true,
                                children:
                                    state.categories.map((e) => e).toList(),
                                widget: (CategoryModel category) {
                                  return HomeViewCategoriesSmallSubWidget(
                                    coverImage: category.coverPhoto.isEmpty
                                        ? AppConstants.mockImage
                                        : category.coverPhoto,
                                    name: category.name,
                                    onTap: () => context
                                        .read<ExploreBloc>()
                                        .add(
                                          CategoryTapEvent(category: category),
                                        ),
                                  );
                                },
                              ),
                            Spacing.vertRegular(),
                            if (state.recentlyAdded.isNotEmpty)
                              HomeSection<PlaceModel>(
                                label: "Recently Added",
                                showSeeAll: true,
                                children:
                                    state.recentlyAdded.map((e) => e).toList(),
                                widget: (PlaceModel place) {
                                  return HomeCategoriesLargeWidget(
                                    showRatings: place.showRatings,
                                    coverImage: place.coverImagePath,
                                    name: place.name,
                                    isBookmarked: place.isBookmarked,
                                    rating: place.avgRating,
                                    ratingCount: place.avgReviewCount,
                                    onTap: () =>
                                        context.read<ExploreBloc>().add(
                                              PlaceTapEvent(place: place),
                                            ),
                                  );
                                },
                              ),
                            Spacing.vertRegular(),
                            if (state.bestRatings.isNotEmpty)
                              HomeSection<PlaceModel>(
                                label: "Best Rating",
                                showSeeAll: true,
                                children:
                                    state.bestRatings.map((e) => e).toList(),
                                widget: (PlaceModel place) {
                                  return HomeCategoriesLargeWidget(
                                    showRatings: place.showRatings,
                                    coverImage: place.coverImagePath,
                                    name: place.name,
                                    isBookmarked: place.isBookmarked,
                                    rating: place.avgRating,
                                    ratingCount: place.avgReviewCount,
                                    onTap: () =>
                                        context.read<ExploreBloc>().add(
                                              PlaceTapEvent(place: place),
                                            ),
                                  );
                                },
                              ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FeaturedSection extends StatelessWidget {
  const FeaturedSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ExploreBloc>().state;
    if (state is! ExploreIdleState) return const SizedBox();
    if (state.exploreDetails.length < 3) return const SizedBox();
    final place1 = state.exploreDetails[0];
    final place2 = state.exploreDetails[1];
    final place3 = state.exploreDetails[2];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Spacing.vertMedium(),
        Text(
          "Explore",
          style: AppTextStyles.medium28
              .copyWith(color: Theme.of(context).colorScheme.onBackground),
        ),
        Spacing.vertTiny(),
        Text(
          "Explore places near you",
          style: AppTextStyles.regular16
              .copyWith(color: Theme.of(context).colorScheme.onBackground),
        ),
        Spacing.vertMedium(),
        SizedBox(
          height: 317.h,
          child: Row(
            children: [
              Expanded(
                flex: 5,
                child: HomeCategoriesLargeWidget(
                  showRatings: place1.showRatings,
                  size: Size.infinite,
                  coverImage: place1.coverImagePath,
                  name: place1.name,
                  isBookmarked: place1.isBookmarked,
                  rating: place1.avgRating,
                  ratingCount: place1.avgReviewCount,
                  onTap: () => context
                      .read<ExploreBloc>()
                      .add(PlaceTapEvent(place: place1)),
                ),
              ),
              Spacing.horizSmall(),
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () => context
                            .read<ExploreBloc>()
                            .add(PlaceTapEvent(place: place2)),
                        child: AppNetworkImage(
                          url: place2.coverImagePath,
                          borderRadius: 18,
                          fit: BoxFit.cover,
                          size: Size.infinite,
                        ),
                      ),
                    ),
                    Spacing.vertSmall(),
                    Expanded(
                      child: InkWell(
                        onTap: () => context
                            .read<ExploreBloc>()
                            .add(PlaceTapEvent(place: place3)),
                        child: AppNetworkImage(
                          url: place3.coverImagePath,
                          borderRadius: 18,
                          fit: BoxFit.cover,
                          size: Size.infinite,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        Spacing.vertMedium(),
      ],
    );
  }
}
