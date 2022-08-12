import 'dart:math';

import 'package:flutter/material.dart';
import 'package:funconnect/constants/colors.dart';
import 'package:funconnect/constants/custom_button.dart';
import 'package:funconnect/constants/fonts.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({Key? key}) : super(key: key);

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final controller = PageController(initialPage: 0);
  int page = 0;
  static const miniLogoImg = 'assets/images/mini_logo.png';

  // void _storeOnboardInfo() async {
  //   int isViewed = 0;
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.setInt('onBoard', isViewed);
  // }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  final List<String> _list = ["Welcome", "Discover", "Connect"];
  final List<String> _listTitle = [
    "See beautiful\nplaces you can visit",
    "See events around\nyour neighborhood",
    "See nearby places\nyou can have fun",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Positioned.fill(
              child: PageView(
                onPageChanged: (val) => setState(() => page = val),
                controller: controller,
                children: _list.map((e) {
                  return Container(
                    color: Color.fromRGBO(100, 100, Random().nextInt(255), 1),
                    // child: Image.network(
                    //   e,
                    //   fit: BoxFit.cover,
                    // ),
                  );
                }).toList(),
              ),
            ),
            IgnorePointer(
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.black,
                      AppColors.transparent,
                    ],
                    stops: [0.02, 0.4],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 29,
              left: 24,
              right: 24,
              top: 0,
              child: IgnorePointer(
                ignoring: false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Expanded(
                          child: Divider(
                            color: AppColors.secondary,
                            thickness: 2,
                          ),
                        ),
                        const SizedBox(width: 7),
                        Expanded(
                          child: Divider(
                            color: page > 0
                                ? AppColors.secondary
                                : AppColors.white,
                            thickness: 2,
                          ),
                        ),
                        const SizedBox(width: 7),
                        Expanded(
                          child: Divider(
                            color: page == 2
                                ? AppColors.secondary
                                : AppColors.white,
                            thickness: 2,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 31),
                    Image.asset(
                      miniLogoImg,
                    ),
                    const SizedBox(height: 31),
                    Text(
                      _listTitle[page],
                      style: const TextStyle(
                        fontSize: 28,
                        color: AppColors.bgLight,
                        fontFamily: AppFonts.merriweather,
                        letterSpacing: 1.3,
                      ),
                    ),
                    const Spacer(),
                    CustomButton(
                      text: "Get started",
                      buttonColor: AppColors.primary,
                      textColor: AppColors.white,
                      height: 64,
                      radius: 50,
                      fontSize: 16,
                      function: () {
                        print("Get started");
                      },
                    ),
                    const SizedBox(height: 16),
                    CustomButton(
                      text: "Login",
                      buttonColor: AppColors.par,
                      textColor: AppColors.white,
                      height: 64,
                      radius: 50,
                      fontSize: 16,
                      function: () {
                        print("Login");
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
