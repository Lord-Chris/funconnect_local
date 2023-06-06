import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:funconnect/features/dashboard/presentation/blocs/dashboard_bloc/dashboard_bloc.dart';
import 'package:funconnect/features/dashboard/presentation/blocs/dashboard_bloc/dashboard_event.dart';
import 'package:funconnect/features/dashboard/presentation/blocs/notification_bloc/notification_bloc.dart';
import 'package:funconnect/features/dashboard/presentation/blocs/notification_bloc/notification_event.dart';
import 'package:funconnect/features/places/domain/entities/category_model.dart';
import 'package:funconnect/features/places/domain/entities/place_model.dart';
import 'package:funconnect/features/places/presentation/blocs/home_bloc/home_bloc.dart';
import 'package:funconnect/features/places/presentation/blocs/home_bloc/home_event.dart';
import 'package:funconnect/features/places/presentation/blocs/home_bloc/home_state.dart';
import 'package:funconnect/shared/constants/_constants.dart';
import 'package:skeletons/skeletons.dart';

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
    context.read<HomeBloc>().add(const HomeInitEvent());
    context.read<NotificationBloc>().add(NotificationInitEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        titleSpacing: 10,
        leading: Center(
          child: InkWell(
            onTap: () => context
                .read<DashboardBloc>()
                .add(TabTapEvent(!Platform.isIOS ? 4 : 3)),
            child: AppNetworkImage(
              size: Size.fromRadius(25.r),
              isCircular: true,
              url: context.watch<HomeBloc>().user.photoUrl,
              cacheImage: false,
              fit: BoxFit.cover,
              placeholderAssetImage: AppAssets.fallbackUserProfileSvg,
            ),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Hi ${context.watch<HomeBloc>().user.name}",
              style: AppTextStyles.medium20,
            ),
            Spacing.vertTiny(),
            Visibility(
              visible: context.watch<HomeBloc>().location != null,
              child: Row(
                children: [
                  const Icon(
                    Icons.location_on,
                    color: AppColors.locationIconAsh,
                    size: 13,
                  ),
                  Flexible(
                    child: Text(
                      context.watch<HomeBloc>().location?.parsedAddress ?? "",
                      style: AppTextStyles.regular14.copyWith(
                        color: AppColors.secondary400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () =>
                context.read<HomeBloc>().add(NotificationTapEvent()),
            icon: Badge(
              isLabelVisible: context
                  .watch<NotificationBloc>()
                  .state
                  .unreadNotifications
                  .isNotEmpty,
              label: Text(context
                  .watch<NotificationBloc>()
                  .state
                  .unreadNotifications
                  .length
                  .toString()),
              child: const Icon(
                CupertinoIcons.bell_fill,
                color: AppColors.white,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Spacing.vertSmall(),
            const Divider(
              color: AppColors.secondary800,
              height: 1,
            ),
            Expanded(
              child: BlocBuilder<HomeBloc, HomeState>(
                buildWhen: (previous, _) => previous is HomeLoadingState,
                builder: (context, state) {
                  if (state is HomeLoadingState) {
                    return Column(
                      children: [
                        const SkeletonLine(),
                        SizedBox(height: 10.h),
                        Row(
                          children: [
                            SkeletonAvatar(
                              style: SkeletonAvatarStyle(
                                width: 120.w,
                                height: 120.h,
                                shape: BoxShape.rectangle,
                              ),
                            ),
                            SizedBox(width: 10.w),
                            SkeletonAvatar(
                              style: SkeletonAvatarStyle(
                                width: 120.w,
                                height: 120.h,
                                shape: BoxShape.rectangle,
                              ),
                            ),
                            SizedBox(width: 10.w),
                            SkeletonAvatar(
                              style: SkeletonAvatarStyle(
                                width: 120.w,
                                height: 120.h,
                                shape: BoxShape.rectangle,
                              ),
                            ),
                          ],
                        )
                      ],
                    );
                  }
                  if (state is! HomeIdleState) return const SizedBox();
                  return Column(
                    children: [
                      BlocBuilder<HomeBloc, HomeState>(
                        buildWhen: (_, current) => current is HomeIdleState,
                        builder: (context, state) {
                          if (state is! HomeIdleState) {
                            return const SizedBox();
                          }
                          if (state.interests.isEmpty) return const SizedBox();
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
                        color: AppColors.secondary800,
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
                              if (state.homeTrends.isEmpty) {
                                return Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Something went wrong. Please try again.",
                                        style: AppTextStyles.medium14,
                                      ),
                                      Spacing.vertRegular(),
                                      AppButton(
                                        label: "Retry",
                                        isCollapsed: true,
                                        labelColor: AppColors.black,
                                        onTap: () => context
                                            .read<HomeBloc>()
                                            .add(const HomeInitEvent()),
                                      )
                                    ],
                                  ),
                                );
                              }
                              if (state.interest != null) {
                                return _InterestSelectedSection(state: state);
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

class _InterestSelectedSection extends StatelessWidget {
  final HomeIdleState state;
  const _InterestSelectedSection({
    Key? key,
    required this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (state.interestPlaces.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "No fun places in this category",
              style: AppTextStyles.medium14,
            ),
          ],
        ),
      );
    }
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Spacing.vertRegular(),
          Padding(
            padding: REdgeInsets.symmetric(horizontal: 16),
            child: Text(
              state.interest!.name,
              textAlign: TextAlign.start,
              style: AppTextStyles.medium28,
            ),
          ),
          Spacing.vertTiny(),
          Padding(
            padding: REdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "Explore the best ${state.interest!.name.toLowerCase()}",
              textAlign: TextAlign.start,
              style: AppTextStyles.regular16,
            ),
          ),
          Spacing.vertRegular(),
          GridView.builder(
            shrinkWrap: true,
            itemCount: state.interestPlaces.length,
            padding: REdgeInsets.symmetric(horizontal: 16),
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 182.r * 1.3,
              childAspectRatio: 1,
              mainAxisSpacing: 10.r,
              crossAxisSpacing: 8.r,
            ),
            itemBuilder: (context, index) {
              final place = state.interestPlaces[index];
              return HomeCategoriesLargeWidget(
                showRatings: place.showRatings,
                coverImage: place.coverImagePath,
                name: place.name,
                isBookmarked: place.isBookmarked,
                rating: place.avgRating,
                ratingCount: place.avgReviewCount,
              );
            },
          ),
        ],
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
      onRefresh: () async {
        final bloc = context.read<HomeBloc>().stream.first;
        context.read<HomeBloc>().add(const HomeInitEvent(showLoader: false));
        await bloc;
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ...state.homeTrends.map((e) {
              if (e.isPlace) {
                if (e.data.isEmpty) return const SizedBox();
                return HomeSection<PlaceModel>(
                  label: e.name,
                  showSeeAll:
                      state.homeTrends.every((item) => item.data.isNotEmpty),
                  initialShowAll:
                      !state.homeTrends.every((item) => item.data.isNotEmpty),
                  children: e.data.map((e) => e as PlaceModel).toList(),
                  widget: (PlaceModel place) {
                    return HomeCategoriesLargeWidget(
                      showRatings: place.showRatings,
                      coverImage: place.coverImagePath,
                      name: place.name,
                      isBookmarked: place.isBookmarked,
                      rating: place.avgRating,
                      ratingCount: place.avgReviewCount,
                      onBookmarkTap: () => context.read<HomeBloc>().add(
                            BookmarkTapEvent(place: place),
                          ),
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
                showSeeAll:
                    state.homeTrends.every((item) => item.data.isNotEmpty),
                initialShowAll:
                    !state.homeTrends.every((item) => item.data.isNotEmpty),
                children: e.data.map((e) => e as CategoryModel).toList(),
                widget: (CategoryModel category) {
                  return HomeViewCategoriesSmallSubWidget(
                    coverImage: category.coverPhoto.isEmpty
                        ? AppConstants.mockImage
                        : category.coverPhoto,
                    name: category.name,
                    onTap: () => context.read<HomeBloc>().add(
                          CategoryTapEvent(category: category),
                        ),
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
