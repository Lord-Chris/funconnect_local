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

  final List<String> _list = [];
  final List<String> _listTitle = [
    "See beautiful places you can visit",
    "See events around your neighborhood",
    "See nearby places you can have fun",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            child: PageView(
              onPageChanged: (val) => setState(() => page = val),
              controller: controller,
              children: _list.map((e) {
                return Image.network(
                  e,
                  fit: BoxFit.cover,
                );
              }).toList(),
            ),
          ),
          Positioned(
            bottom: 29,
            left: 24,
            right: 24,
            top: 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
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
                        color: page > 0 ? AppColors.secondary : AppColors.white,
                        thickness: 2,
                      ),
                    ),
                    const SizedBox(width: 7),
                    Expanded(
                      child: Divider(
                        color:
                            page == 2 ? AppColors.secondary : AppColors.white,
                        thickness: 2,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 31),
                Image.asset(
                  miniLogoImg,
                  scale: 3.5,
                ),
                const SizedBox(height: 31),
                Text(
                  _listTitle[page],
                  style: const TextStyle(
                    fontSize: 28,
                    color: AppColors.bgLight,
                    fontFamily: AppFonts.gtWalshPro,
                  ),
                ),
                const Spacer(),
                CustomButton(
                  text: "Get started",
                  buttonColor: AppColors.primary,
                  height: 64,
                  radius: 50,
                  fontSize: 16,
                  function: () {},
                ),
                const SizedBox(height: 16),
                CustomButton(
                  text: "Login",
                  buttonColor: AppColors.par,
                  height: 64,
                  radius: 50,
                  fontSize: 16,
                  function: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
