import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:funconnect/features/dashboard/presentation/blocs/dashboard_bloc/dashboard_bloc.dart';
import 'package:funconnect/features/dashboard/presentation/blocs/dashboard_bloc/dashboard_event.dart';
import 'package:funconnect/features/dashboard/presentation/blocs/dashboard_bloc/dashboard_state.dart';
import 'package:funconnect/features/events/presentation/blocs/events_bloc/events_bloc.dart';
import 'package:funconnect/features/saved/presentation/blocs/saved_bloc.dart';
import 'package:funconnect/features/saved/presentation/views/saved_view.dart';
import 'package:funconnect/features/places/presentation/blocs/explore_bloc/explore_bloc.dart';
import 'package:funconnect/features/places/presentation/blocs/home_bloc/home_bloc.dart';
import 'package:funconnect/features/places/presentation/views/home_view.dart';
import 'package:funconnect/features/profile/presentation/blocs/profile_bloc/profile_bloc.dart';
import 'package:funconnect/features/profile/presentation/views/profile_view.dart';
import 'package:funconnect/shared/components/app_loader.dart';
import 'package:funconnect/shared/constants/_constants.dart';
import 'package:lazy_load_indexed_stack/lazy_load_indexed_stack.dart';

import '../../../events/presentation/views/events_view.dart';
import '../../../places/presentation/views/explore_view.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => DashboardBloc()),
        BlocProvider(create: (context) => HomeBloc()),
        BlocProvider(create: (context) => ExploreBloc()),
        BlocProvider(create: (context) => EventsBloc()),
        BlocProvider(create: (context) => ProfileBloc()),
        BlocProvider(create: (context) => SavedBloc()),
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
                  children: const [
                    HomeView(),
                    ExploreView(),
                    EventsView(),
                    SavedView(),
                    ProfileView(),
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
              onTap: (index) =>
                  context.read<DashboardBloc>().add(TabTapEvent(index)),
              selectedFontSize: 20,
              unselectedFontSize: 14,
              type: BottomNavigationBarType.fixed,
              unselectedItemColor: AppColors.secondary400,
              selectedItemColor: AppColors.primary,
              selectedLabelStyle: const TextStyle(
                height: 1.3,
                fontSize: 12,
                fontFamily: AppFonts.gtWalshPro,
                fontWeight: FontWeight.w400,
                color: AppColors.primary,
              ),
              unselectedLabelStyle: const TextStyle(
                fontSize: 12,
                height: 1.3,
                fontFamily: AppFonts.gtWalshPro,
                fontWeight: FontWeight.w400,
                color: AppColors.secondary400,
              ),
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
