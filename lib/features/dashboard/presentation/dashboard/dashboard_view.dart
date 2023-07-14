import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:funconnect/features/dashboard/presentation/dashboard/bloc/dashboard_bloc.dart';
import 'package:funconnect/features/dashboard/presentation/dashboard/bloc/dashboard_event.dart';
import 'package:funconnect/features/dashboard/presentation/dashboard/bloc/dashboard_state.dart';
import 'package:funconnect/features/dashboard/presentation/notifications/bloc/notification_bloc.dart';
import 'package:funconnect/features/events/presentation/blocs/events_bloc/events_bloc.dart';
import 'package:funconnect/features/places/presentation/explore/bloc/explore_bloc.dart';
import 'package:funconnect/features/plans/presentation/plans_list/bloc/plan_list_bloc.dart';
import 'package:funconnect/features/plans/presentation/plans_list/plans_list_view.dart';
import 'package:funconnect/features/profile/presentation/profile/profile_view.dart';
import 'package:funconnect/features/saved/presentation/saved/bloc/saved_bloc.dart';
import 'package:funconnect/features/saved/presentation/saved/saved_view.dart';
import 'package:funconnect/shared/components/app_loader.dart';
import 'package:funconnect/shared/constants/_constants.dart';
import 'package:lazy_load_indexed_stack/lazy_load_indexed_stack.dart';

import '../../../events/presentation/views/events_view.dart';
import '../../../places/presentation/explore/explore_view.dart';
import '../../../places/presentation/home/bloc/home_bloc.dart';
import '../../../places/presentation/home/bloc/home_event.dart';
import '../../../places/presentation/home/home_view.dart';
import '../../../profile/presentation/profile/bloc/profile_bloc.dart';
import '../../../saved/presentation/saved/bloc/saved_event.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => HomeBloc()),
        BlocProvider(create: (context) => ExploreBloc()),
        if (!Platform.isIOS) BlocProvider(create: (context) => EventsBloc()),
        BlocProvider(create: (context) => ProfileBloc()),
        BlocProvider(create: (context) => SavedBloc()),
        BlocProvider(create: (context) => NotificationBloc()),
        BlocProvider(
          create: (context) => PlanListBloc(),
        )
      ],
      child: BlocBuilder<DashboardBloc, DashboardState>(
        buildWhen: (previous, current) => current is DashboardIdleState,
        builder: (context, state) {
          if (state is! DashboardIdleState) return const SizedBox();
          return Scaffold(
            body: Stack(
              children: [
                LazyLoadIndexedStack(
                  index: state.navBarIndex,
                  children: [
                    const HomeView(),
                    const ExploreView(),
                    if (!Platform.isIOS) const EventsView(),
                    const PlansListView(),
                    const SavedView(),
                    const ProfileView(),
                  ],
                ),
                BlocBuilder<DashboardBloc, DashboardState>(
                  builder: (context, state) {
                    if (state is! LinkLoadingState) return const SizedBox();
                    return Container(
                      color: AppColors.black.withOpacity(.6),
                      child: const AppLoader(
                        color: AppColors.primary,
                      ),
                    );
                  },
                )
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              backgroundColor: AppColors.black,
              currentIndex: state.navBarIndex,
              onTap: (index) {
                if (index == (Platform.isIOS ? 2 : 3)) {
                  context
                      .read<SavedBloc>()
                      .add(const GetAllUserSavedPlaces(showLoader: false));
                }
                if (index == 0) {
                  context
                      .read<HomeBloc>()
                      .add(const HomeInitEvent(showLoader: false));
                }
                context.read<DashboardBloc>().add(TabTapEvent(index));
              },
              selectedFontSize: 20,
              unselectedFontSize: 14,
              type: BottomNavigationBarType.fixed,
              unselectedItemColor: AppColors.secondary400,
              selectedItemColor: AppColors.primary,
              selectedLabelStyle: AppTextStyles.regular12,
              unselectedLabelStyle: AppTextStyles.regular12,
              showUnselectedLabels: true,
              iconSize: 16,
              items: [
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: SvgPicture.asset(
                      AppAssets.homeIconSvg,
                    ),
                  ),
                  activeIcon: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: SvgPicture.asset(
                      AppAssets.activeHomeIconSvg,
                    ),
                  ),
                  label: "Home",
                  backgroundColor: Colors.white,
                ),
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: SvgPicture.asset(AppAssets.exploreIconSvg),
                  ),
                  activeIcon: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: SvgPicture.asset(
                      AppAssets.activeExploreIconSvg,
                    ),
                  ),
                  label: "Explore",
                  backgroundColor: Colors.white,
                ),
                if (!Platform.isIOS)
                  BottomNavigationBarItem(
                    icon: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: SvgPicture.asset(AppAssets.eventIconSvg),
                    ),
                    activeIcon: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: SvgPicture.asset(
                        AppAssets.activeEventIconSvg,
                      ),
                    ),
                    label: "Events",
                    backgroundColor: Colors.white,
                  ),
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: SvgPicture.asset(AppAssets.plannerSvg),
                  ),
                  activeIcon: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: SvgPicture.asset(
                      AppAssets.plannerActiveSvg,
                    ),
                  ),
                  label: "Planner",
                  backgroundColor: Colors.white,
                ),
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: SvgPicture.asset(AppAssets.savedIconSvg),
                  ),
                  activeIcon: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: SvgPicture.asset(
                      AppAssets.activeSavedIconSvg,
                    ),
                  ),
                  label: "Saved",
                  backgroundColor: Colors.white,
                ),
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: SvgPicture.asset(AppAssets.profIconSvg),
                  ),
                  activeIcon: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: SvgPicture.asset(
                      AppAssets.activeProfileIconSvg,
                    ),
                  ),
                  label: "Profile",
                  backgroundColor: Colors.white,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
