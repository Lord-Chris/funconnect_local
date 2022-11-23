import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:funconnect/features/dashboard/presentation/views/home_view.dart';
import 'package:funconnect/shared/components/_components.dart';
import 'package:funconnect/shared/constants/_constants.dart';

class ExploreView extends StatefulWidget {
  const ExploreView({Key? key}) : super(key: key);
  static const List<String> _tabs = [
    "Party",
    "Viewing Center",
    "Hotel",
    "Fuel Station",
    "Market",
    "Chruch",
    "Barber Salon",
    "Gas Station",
    "Party",
    "Viewing Center",
    "Hotel",
    "Fuel Station",
    "Party",
    "Viewing Center",
    "Hotel",
    "Fuel Station",
  ];

  @override
  State<ExploreView> createState() => _ExploreViewState();
}

class _ExploreViewState extends State<ExploreView> {
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 240,
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15.0, left: 30),
                    child: IconButton(
                        onPressed: () {
                          Navigator.of(context, rootNavigator: true).push(
                              CupertinoPageRoute(
                                  fullscreenDialog: true,
                                  builder: (_) => const HomeView()));
                        },
                        icon: const Icon(Icons.arrow_back_ios)),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 15.0, left: 10),
                    child: Text(
                      "Explore",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        fontFamily: AppFonts.gtWalshPro,
                        height: 1.3,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                  ),
                  const AppTextField(
                    prefix: Icon(Icons.search, color: AppColors.grey),
                    hint: "Search Center, People, places...",
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Wrap(
                    direction: Axis.horizontal,
                    children: [
                      ...ExploreView._tabs.map(
                        (tab) => Container(
                          margin: const EdgeInsets.all(5),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            border: Border.all(
                                color: AppColors.grey.withOpacity(.2)),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            tab,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              fontFamily: AppFonts.gtWalshPro,
                              height: 1.3,
                              color: AppColors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                controller: _scrollController,
                padding: const EdgeInsets.all(25),
                shrinkWrap: true,
                children: [
                  const Text(
                    "Search Results (234)",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      fontFamily: AppFonts.gtWalshPro,
                      height: 1.3,
                      color: AppColors.black,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ListView.builder(
                    controller: _scrollController,
                    shrinkWrap: true,
                    itemCount: 5,
                    itemBuilder: (__, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CardView(),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 15.0),
                            child: Text(
                              "Pleasure Beach",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                fontFamily: AppFonts.gtWalshPro,
                                height: 1.3,
                                color: AppColors.black,
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 5.0),
                            child: Text(
                              "Brief Description of place and it’s value",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                fontFamily: AppFonts.gtWalshPro,
                                height: 1.3,
                                color: AppColors.black,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Row(
                              children: const [
                                Text(
                                  "3.5",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: AppFonts.gtWalshPro,
                                    height: 1.3,
                                    color: AppColors.black,
                                  ),
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.purple,
                                  size: 15,
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
