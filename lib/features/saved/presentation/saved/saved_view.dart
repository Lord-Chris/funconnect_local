import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:funconnect/features/places/domain/entities/saved_place_model.dart';
import 'package:funconnect/features/saved/presentation/saved/bloc/saved_bloc.dart';
import 'package:funconnect/features/saved/presentation/saved/bloc/saved_event.dart';
import 'package:funconnect/features/saved/presentation/saved/bloc/saved_state.dart';
import 'package:funconnect/features/saved/presentation/saved/widgets/saved_place_widget.dart';
import 'package:funconnect/shared/components/custom_button.dart';
import 'package:logger/logger.dart';

import '../../../../shared/components/app_loader.dart';
import '../../../../shared/constants/_constants.dart';
import 'widgets/saved_events_tab.dart';

class SavedView extends StatefulWidget {
  const SavedView({Key? key}) : super(key: key);

  @override
  State<SavedView> createState() => _SavedViewState();
}

class _SavedViewState extends State<SavedView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    if (!Platform.isIOS) {
      _tabController = TabController(length: 2, vsync: this);
    } else {
      _tabController = TabController(length: 1, vsync: this);
    }
    context.read<SavedBloc>().add(const GetAllUserSavedPlaces());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SavedBloc, SavedState>(
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  contentPadding: REdgeInsets.fromLTRB(16, 30, 16, 0),
                  title: Text(
                    AppText.aTSaved,
                    style: AppTextStyles.medium28.copyWith(
                        color: Theme.of(context).colorScheme.onBackground),
                  ),
                  subtitle: Text(
                    AppText.aTSavedSubtext,
                    style: AppTextStyles.regular16.copyWith(
                      color: AppColors.eventBasedColor,
                    ),
                  ),
                  // trailing: GestureDetector(
                  //   onTap: () => locator<INavigationService>()
                  //       .toNamed(Routes.createCollectionViewRoute),
                  //   child: const Icon(
                  //     Icons.more_vert,
                  //     color: AppColors.white,
                  //   ),
                  // ),
                ),
                TabBar(
                  controller: _tabController,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorColor: AppColors.primary,
                  indicatorWeight: 3,
                  labelColor: AppColors.primary,
                  labelStyle: AppTextStyles.medium16,
                  unselectedLabelColor:
                      Theme.of(context).colorScheme.onBackground,
                  unselectedLabelStyle: AppTextStyles.medium16,
                  tabs: [
                    Tab(
                      text: 'Recreation (${state.savedPlaces.length})',
                    ),
                    if (!Platform.isIOS)
                      const Tab(
                        text: 'Events (0)',
                      ),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      BlocBuilder<SavedBloc, SavedState>(
                        builder: (context, state) {
                          if (state is SavedLoadingState) {
                            return const AppLoader(
                              color: AppColors.primary,
                            );
                          }
                          if (state is SavedFailureState) {
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
                                    labelColor: AppColors.black,
                                    onTap: () => context
                                        .read<SavedBloc>()
                                        .add(const GetAllUserSavedPlaces()),
                                  )
                                ],
                              ),
                            );
                          }
                          if (state is! SavedPageFilledState) {
                            return const SizedBox();
                          }
                          if (state.savedPlaces.isEmpty) {
                            return const SavedEmptyPage();
                          }
                          Logger().i(state.savedPlaces.length);
                          return SavedPage(savedPlaces: state.savedPlaces);
                        },
                      ),
                      if (!Platform.isIOS)
                        SavedEventsTab(tabController: _tabController),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
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
              AppButton(
                label: 'Refresh',
                labelColor: AppColors.black,
                isCollapsed: true,
                borderRadius: 12,
                onTap: () => context
                    .read<SavedBloc>()
                    .add(const GetAllUserSavedPlaces()),
              ),

              // AppButton(
              //   label: 'Add Collection',
              //   labelColor: AppColors.gray97,
              //   buttonColor: AppColors.imgContainerBlack,
              //   isCollapsed: true,
              //   borderRadius: 12,
              //   padding: REdgeInsets.fromLTRB(40, 16, 40, 16),
              //   onTap: () => locator<INavigationService>()
              //       .toNamed(Routes.createCollectionViewRoute),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class SavedPage extends StatelessWidget {
  final List<SavedPlaceModel> savedPlaces;

  const SavedPage({
    Key? key,
    required this.savedPlaces,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        final bloc = context.read<SavedBloc>();
        bloc.add(const GetAllUserSavedPlaces(showLoader: false));
        await bloc.stream.first;
      },
      child: GridView.builder(
        itemCount: savedPlaces.length,
        padding: REdgeInsets.fromLTRB(16, 20, 16, 20),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 187.r * 1.3,
          // mainAxisExtent: 187.r,
          mainAxisSpacing: 10.r,
          crossAxisSpacing: 8.r,
        ),
        itemBuilder: (context, index) {
          final place = savedPlaces[index];
          return SavedPlaceWidget(
            coverImage: place.place!.coverImagePath,
            name: place.place!.name,
            isBookmarked: true,
            size: Size.infinite,
            onTap: () =>
                context.read<SavedBloc>().add(SavedPlaceTapEvent(place: place)),
          );
        },
      ),
    );
  }
}
