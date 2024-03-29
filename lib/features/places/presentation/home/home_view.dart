import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:funconnect/core/blocs/main_app_bloc.dart';
import 'package:funconnect/features/dashboard/presentation/dashboard/bloc/dashboard_bloc.dart';
import 'package:funconnect/features/dashboard/presentation/dashboard/bloc/dashboard_event.dart';
import 'package:funconnect/features/dashboard/presentation/notifications/bloc/notification_bloc.dart';
import 'package:funconnect/features/dashboard/presentation/notifications/bloc/notification_event.dart';
import 'package:funconnect/features/places/domain/entities/category_model.dart';
import 'package:funconnect/features/places/domain/entities/place_model.dart';
import 'package:funconnect/features/places/presentation/home/bloc/home_bloc.dart';
import 'package:funconnect/features/places/presentation/home/bloc/home_event.dart';
import 'package:funconnect/features/places/presentation/home/bloc/home_state.dart';
import 'package:funconnect/shared/constants/_constants.dart';

import '../../../../shared/components/_components.dart';
import 'widgets/categories_large_widget.dart';
import 'widgets/categories_small_widget.dart';
import 'widgets/categories_widget.dart';
import 'widgets/home_skeleton.dart';
import 'widgets/interest_widget.dart';

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
    context.read<NotificationBloc>().add(NotificationInitEvent(false));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: Row(
                children: [
                  InkWell(
                      onTap: () => context
                          .read<DashboardBloc>()
                          .add(TabTapEvent(!Platform.isIOS ? 5 : 4)),
                      child: AppNetworkImage(
                        size: Size.fromRadius(25.r),
                        isCircular: true,
                        url: context.watch<MainAppBloc>().user.photoUrl,
                        cacheImage: false,
                        fit: BoxFit.cover,
                        placeholderAssetImage: AppAssets.fallbackUserProfileSvg,
                      )),
                  SizedBox(
                    width: 14.w,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          "Hi ${context.watch<MainAppBloc>().user.username}",
                          style: AppTextStyles.medium20.copyWith(
                              color:
                                  Theme.of(context).colorScheme.onBackground),
                        ),
                        if ((context
                                    .watch<MainAppBloc>()
                                    .location
                                    ?.parsedAddress ??
                                "")
                            .isNotEmpty) ...[
                          Spacing.vertTiny(),
                          Visibility(
                            visible:
                                context.watch<MainAppBloc>().location != null,
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.location_on,
                                  color: AppColors.locationIconAsh,
                                  size: 13,
                                ),
                                Flexible(
                                  child: Text(
                                    context
                                            .watch<MainAppBloc>()
                                            .location
                                            ?.parsedAddress ??
                                        "",
                                    style: AppTextStyles.regular14.copyWith(
                                      color: AppColors.secondary400,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ]
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () =>
                        context.read<HomeBloc>().add(NotificationTapEvent()),
                    icon: Badge(
                      isLabelVisible: context
                          .watch<NotificationBloc>()
                          .state
                          .showNotificationBadge,
                      smallSize: 10,
                      textColor: AppColors.white,
                      child: Icon(
                        CupertinoIcons.bell_fill,
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Spacing.vertSmall(),
            Divider(
              color: Theme.of(context).brightness == Brightness.dark
                  ? AppColors.secondary800
                  : AppColors.wGreyF8,
              height: 1.h,
            ),
            Expanded(
              child: BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  if (state is HomeLoadingState) {
                    return const HomeSkeleton();
                  }
                  if (state is! HomeIdleState) return const SizedBox();
                  context
                      .read<MainAppBloc>()
                      .add(PlacesLoaded(state.homeTrends!));
                  return Column(
                    children: [
                      BlocBuilder<HomeBloc, HomeState>(
                        buildWhen: (_, current) => current is HomeIdleState,
                        builder: (context, state) {
                          if (state is! HomeIdleState) {
                            return const SizedBox();
                          }
                          if (state.interests.isEmpty) {
                            return const SizedBox();
                          }
                          return SizedBox(
                            height: 50.h,
                            width: MediaQuery.of(context).size.width,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
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
                            ),
                          );
                        },
                      ),
                      Divider(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? AppColors.secondary800
                            : AppColors.wGreyF8,
                        height: 1.h,
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
                              if (state.homeCategory.isEmpty ||
                                  state.homeCategory.isEmpty) {
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
      child: ScrollableColumn(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          HomeSection<CategoryModel>(
            label: state.homeCategory.first.name,
            itemHeight: 136.r,
            showSeeAll: false,
            children: state.homeCategory.first.data.map((e) => e).toList(),
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
          ),
          ...state.homePlaces.map((e) {
            if (e.data.isEmpty) return const SizedBox();
            return HomeSection<PlaceModel>(
              label: e.name,
              showSeeAll: false,
              children: e.data.map((e) => e).toList(),
              widget: (PlaceModel place) {
                return HomeCategoriesLargeWidget(
                  showRatings: place.showRatings,
                  coverImage: place.coverImagePath,
                  name: place.name,
                  isBookmarked: place.isBookmarked,
                  rating: place.avgRating,
                  ratingCount: place.avgReviewCount,
                  cacheImage: true,
                  onBookmarkTap: () async {
                    final bloc = context.read<HomeBloc>().stream.first;
                    context.read<HomeBloc>().add(BookmarkTapEvent(place));
                    await bloc;
                  },
                  onTap: () =>
                      context.read<HomeBloc>().add(PlaceTapEvent(place)),
                );
              },
            );
          }),
        ],
      ),
    );
  }
}
