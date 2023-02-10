import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:funconnect/features/places/domain/entities/category_model.dart';
import 'package:funconnect/features/places/domain/entities/place_model.dart';
import 'package:funconnect/features/places/presentation/blocs/home_bloc/home_bloc.dart';
import 'package:funconnect/features/places/presentation/blocs/home_bloc/home_event.dart';
import 'package:funconnect/features/places/presentation/blocs/home_bloc/home_state.dart';
import 'package:funconnect/shared/constants/_constants.dart';

import '../../../../shared/components/_components.dart';
import '../widgets/home_categories_large_widget.dart';
import '../widgets/home_categories_small_widget.dart';
import '../widgets/home_categories_widget.dart';
import '../widgets/home_interest_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(HomeInitEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        leading: AppNetworkImage(
          borderRadius: 50.r,
          isCircular: true,
          url: AppConstants.mockImage,
          fit: BoxFit.cover,
        ),
        title: Column(
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
        actions: [
          IconButton(
            onPressed: () =>
                context.read<HomeBloc>().add(NotificationTapEvent()),
            icon: const Icon(
              CupertinoIcons.bell_fill,
              color: AppColors.white,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Spacing.vertSmall(),
            const Divider(
              color: AppColors.secondary500,
              height: 1,
            ),
            Expanded(
              child: BlocBuilder<HomeBloc, HomeState>(
                buildWhen: (previous, _) => previous is HomeLoadingState,
                builder: (context, state) {
                  if (state is HomeLoadingState) {
                    return const AppLoader(
                      color: AppColors.primary,
                    );
                  }
                  if (state is! HomeIdleState) return const SizedBox();
                  return Column(
                    children: [
                      BlocBuilder<HomeBloc, HomeState>(
                        buildWhen: (_, current) => current is HomeIdleState,
                        builder: (context, state) {
                          if (state is! HomeIdleState) return const SizedBox();
                          return SizedBox(
                            height: 50.h,
                            width: MediaQuery.of(context).size.width,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              padding: EdgeInsets.symmetric(vertical: 8.h),
                              itemCount: state.interests.length,
                              itemBuilder: (context, index) {
                                final interest = state.interests[index];
                                return Padding(
                                  padding: EdgeInsets.only(left: 5.r),
                                  child: HomeInterestWidget(
                                    interest: interest,
                                    isSelected: state.interest == interest,
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
                      const Divider(
                        color: AppColors.secondary500,
                        height: 1,
                      ),
                      Spacing.vertSmall(),
                      Expanded(
                        child: BlocBuilder<HomeBloc, HomeState>(
                          builder: (context, state) {
                            if (state is HomeSubLoadingState) {
                              return const AppLoader(
                                color: AppColors.primary,
                              );
                            }
                            if (state is HomeIdleState) {
                              if (state.interestPlaces.isNotEmpty) {
                                return SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Spacing.vertRegular(),
                                      Padding(
                                        padding: REdgeInsets.symmetric(
                                            horizontal: 16),
                                        child: Text(
                                          "Fine Dining",
                                          style: AppTextStyles.medium28,
                                        ),
                                      ),
                                      Spacing.vertTiny(),
                                      Padding(
                                        padding: REdgeInsets.symmetric(
                                            horizontal: 16),
                                        child: Text(
                                          "Explore the best cuisines",
                                          style: AppTextStyles.regular16,
                                        ),
                                      ),
                                      Spacing.vertRegular(),
                                      GridView.builder(
                                        shrinkWrap: true,
                                        itemCount: 5,
                                        padding: REdgeInsets.symmetric(
                                            horizontal: 16),
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        gridDelegate:
                                            SliverGridDelegateWithMaxCrossAxisExtent(
                                          maxCrossAxisExtent: 182.r * 1.3,
                                          childAspectRatio: 1,
                                          mainAxisSpacing: 10.r,
                                          crossAxisSpacing: 8.r,
                                        ),
                                        itemBuilder: (context, index) {
                                          final place = mockPlace;
                                          return HomeCategoriesLargeWidget(
                                            coverImage: place.coverImagePath,
                                            name: place.name,
                                            isBookmarked: false,
                                            rating: place.avgRating,
                                            ratingCount: place.avgReviewCount,
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              }
                              if (state.interestPlaces.isEmpty) {
                                return _DefaultHomeView(state: state);
                              }
                            }
                            return const SizedBox();
                          },
                        ),
                      ),
                    ],
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

class _DefaultHomeView extends StatelessWidget {
  final HomeIdleState state;
  const _DefaultHomeView({
    Key? key,
    required this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => context.read<HomeBloc>().add(HomeInitEvent()),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ...state.homeTrends.map((e) {
              if (e.isPlace) {
                return HomeSection<PlaceModel>(
                  label: e.name,
                  children: List.filled(10, mockPlace).map((e) => e).toList(),
                  widget: (PlaceModel place) {
                    return HomeCategoriesLargeWidget(
                      coverImage: place.coverImagePath,
                      name: place.name,
                      isBookmarked: false,
                      rating: place.avgRating,
                      ratingCount: place.avgReviewCount,
                      onTap: () => context.read<HomeBloc>().add(
                            PlaceTapEvent(place: place),
                          ),
                    );
                  },
                );
              }
              return HomeSection<CategoryModel>(
                label: e.name,
                itemHeight: 136.r,
                children: e.data.map((e) => e as CategoryModel).toList(),
                widget: (CategoryModel place) {
                  return HomeViewCategoriesSmallSubWidget(
                    coverImage: place.coverPhoto.isEmpty
                        ? AppConstants.mockImage
                        : place.coverPhoto,
                    name: place.name,
                  );
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}
