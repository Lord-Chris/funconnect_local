import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:funconnect/features/fun_connect/saved/domain/entities/saved_place_model.dart';
import 'package:funconnect/features/fun_connect/saved/presentation/blocs/saved_bloc.dart';
import 'package:funconnect/features/fun_connect/saved/presentation/blocs/saved_event.dart';
import 'package:funconnect/features/fun_connect/saved/presentation/blocs/saved_state.dart';
import 'package:funconnect/shared/constants/app_spacer.dart';
import 'package:funconnect/shared/constants/colors.dart';

import '../../../../../core/app/locator.dart';
import '../../../../../core/app/routes.dart';
import '../../../../../services/navigation_service/i_navigation_service.dart';
import '../../../../../shared/components/app_loader.dart';
import '../../../../../shared/constants/app_text.dart';
import '../../../../../shared/constants/textstyles.dart';
import '../../../../places/presentation/widgets/home_categories_large_widget.dart';
import '../../../../places/presentation/widgets/home_categories_widget.dart';

class SavedView extends StatefulWidget {
  const SavedView({Key? key}) : super(key: key);

  @override
  State<SavedView> createState() => _SavedViewState();
}

class _SavedViewState extends State<SavedView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late Place place;
  late final SavedBloc _savedBloc;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
    _savedBloc = SavedBloc();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SavedBloc>(
      create: (context) {
        return _savedBloc..add(GetAllUserSavedPlaces());
      },
      child: Scaffold(
        backgroundColor: AppColors.black,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Padding(
                    padding: EdgeInsets.only(
                        left: 8.0.w, bottom: 8.0.h, top: 32.0.h),
                    child: Text(
                      AppText.aTSaved,
                      style: AppTextStyles.medium28,
                    ),
                  ),
                  subtitle: Padding(
                    padding: EdgeInsets.only(left: 8.0.w, bottom: 32.0.h),
                    child: Text(
                      AppText.aTSavedSubtext,
                      style: AppTextStyles.medium16.copyWith(
                        color: AppColors.eventBasedColor,
                      ),
                    ),
                  ),
                  trailing: GestureDetector(
                    onTap: () => locator<INavigationService>()
                        .toNamed(Routes.createCollectionViewRoute),
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: 8.0.w,
                          right: 8.0.w,
                          bottom: 8.0.h,
                          top: 32.0.h),
                      child: const Icon(
                        Icons.more_vert,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ),
                TabBar(
                  controller: _tabController,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorColor: AppColors.primary,
                  indicatorWeight: 4,
                  labelColor: AppColors.primary,
                  labelStyle:
                      AppTextStyles.medium16.copyWith(color: AppColors.primary),
                  unselectedLabelColor: Colors.white,
                  unselectedLabelStyle:
                      AppTextStyles.medium16.copyWith(color: Colors.white),
                  tabs: const [
                    Tab(
                      text: 'Recreation(0)',
                    ),
                    Tab(
                      text: 'Events(0)',
                    ),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      BlocBuilder<SavedBloc, SavedState>(
                          buildWhen: (previous, _) =>
                              previous is SavedLoadingState,
                          builder: (context, state) {
                            if (state is SavedLoadingState) {
                              return const AppLoader(
                                color: AppColors.primary,
                              );
                            }
                            if (state is! SavedEmptyPage) {
                              return const SizedBox();
                            }
                            return Column(
                              children: [
                                BlocBuilder<SavedBloc, SavedState>(
                                    buildWhen: (_, current) =>
                                        current is SavedLoadingState,
                                    builder: (context, state) {
                                      if (state is! UserSavedPageFilledState) {
                                        return const SizedBox();
                                      }
                                      if (state.savedPlaces.isNotEmpty) {
                                        return SavedPage(state: state);
                                      } else if (state.savedPlaces.isEmpty) {
                                        return const SavedEmptyPage();
                                      }
                                      return const SizedBox();
                                    }),
                              ],
                            );
                          }),
                      Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 16.h, horizontal: 24.w),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "No saved items yet",
                                  style: AppTextStyles.regular16
                                      .copyWith(color: AppColors.secondary500),
                                ),
                                Spacing.vertMedium(),
                                Container(
                                  width: 189.0.w,
                                  height: 48.0.h,
                                  decoration: BoxDecoration(
                                    color: AppColors.imgContainerBlack,
                                    borderRadius: BorderRadius.circular(12.0.r),
                                  ),
                                  child: GestureDetector(
                                    onTap: () => locator<INavigationService>()
                                        .toNamed(
                                            Routes.createCollectionViewRoute),
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            40, 16, 40, 16),
                                        child: Text(
                                          "Add collection",
                                          style:
                                              AppTextStyles.medium20.copyWith(
                                            color: AppColors.gray97,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SavedEmptyPage extends StatelessWidget {
  const SavedEmptyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 24.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "No saved items yet",
                style: AppTextStyles.regular16
                    .copyWith(color: AppColors.secondary500),
              ),
              Spacing.vertMedium(),
              Container(
                width: 189.0.w,
                height: 48.0.h,
                decoration: BoxDecoration(
                  color: AppColors.imgContainerBlack,
                  borderRadius: BorderRadius.circular(12.0.r),
                ),
                child: GestureDetector(
                  onTap: () => locator<INavigationService>()
                      .toNamed(Routes.createCollectionViewRoute),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(40, 16, 40, 16),
                      child: Text(
                        "Add collection",
                        style: AppTextStyles.medium20.copyWith(
                          color: AppColors.gray97,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SavedPage extends StatelessWidget {
  final UserSavedPageFilledState state;
  final Place? place;
  const SavedPage({Key? key, required this.state, this.place})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<SavedBloc>().add(const SavedInitial(showLoader: false));
      },
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ...state.savedPlaces.map((e) {
              if (e.id.isNotEmpty) {
                return HomeSection<Place>(
                  // label: e.place.name,
                  //children: e.data.map((e) => e as Place).toList(),
                  widget: (Place place) {
                    return HomeCategoriesLargeWidget(
                      coverImage: place.coverImagePath,
                      name: place.name,
                      isBookmarked: false,
                      rating: place.avgRating,
                      ratingCount: place.avgReviewCount,
                      onTap: () => context.read<SavedBloc>().add(
                            SavedPlaceTapEvent(place: place),
                          ),
                    );
                  },
                );
              }
              return const SizedBox();
            }),
          ],
        ),
      ),
    );
  }
}
