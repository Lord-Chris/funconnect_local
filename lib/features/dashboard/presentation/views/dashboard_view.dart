import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:funconnect/features/dashboard/presentation/views/favourites_view.dart';
import 'package:funconnect/features/dashboard/presentation/views/home_view.dart';
import 'package:funconnect/features/fun_connect/event/presentation/events_view.dart';
import 'package:funconnect/shared/constants/_constants.dart';

import '../../../fun_connect/explore/presentation/explore_view.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  final List<Widget> _tabs = const [
    HomeView(),
    FavouritesView(),
    EventsView(),
    ExploreView(),
    EventsView(),
  ];

  int _index = 0;

  void onTap(int index) {
    setState(() {
      _index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _tabs[_index],
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
