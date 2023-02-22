import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:funconnect/features/events/presentation/blocs/events_bloc/events_bloc.dart';
import 'package:funconnect/features/places/presentation/blocs/explore_bloc/explore_bloc.dart';
import 'package:funconnect/features/places/presentation/blocs/home_bloc/home_bloc.dart';
import 'package:funconnect/features/places/presentation/views/home_view.dart';
import 'package:funconnect/features/profile/presentation/blocs/profile_bloc/profile_bloc.dart';
import 'package:funconnect/features/profile/presentation/views/profile_view.dart';
import 'package:funconnect/shared/constants/_constants.dart';
import 'package:lazy_load_indexed_stack/lazy_load_indexed_stack.dart';

import '../../../events/presentation/views/events_view.dart';
import '../../../places/presentation/views/explore_view.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  int _index = 0;

  void onTap(int index) {
    setState(() {
      _index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LazyLoadIndexedStack(
        index: _index,
        children: [
          BlocProvider<HomeBloc>(
            create: (context) => HomeBloc(),
            child: const HomeView(),
          ),
          BlocProvider<ExploreBloc>(
            create: (context) => ExploreBloc(),
            child: const ExploreView(),
          ),
          BlocProvider<EventsBloc>(
            create: (context) => EventsBloc(),
            child: const EventsView(),
          ),
          const Placeholder(),
          BlocProvider(
            create: (context) => ProfileBloc(),
            child: const ProfileView(),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.black,
        currentIndex: _index,
        onTap: onTap,
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
  }
}
