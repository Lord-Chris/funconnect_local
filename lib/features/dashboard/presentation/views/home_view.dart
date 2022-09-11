import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:funconnect/shared/components/_components.dart';
import 'package:funconnect/shared/constants/app_assets.dart';
import 'package:funconnect/shared/constants/colors.dart';
import 'package:funconnect/shared/constants/fonts.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  static const List<String> _tabs = [
    "Party",
    "Viewing Center",
    "Hotel",
    "Gas Station",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLight,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          "Hello, Chukwuemeka",
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: AppFonts.gtWalshPro,
                            fontWeight: FontWeight.w400,
                            height: 1.3,
                            color: AppColors.black,
                          ),
                        ),
                      ),
                      SvgPicture.asset(AppAssets.notIconSvg),
                      const SizedBox(
                        height: 16,
                      ),
                      InkWell(
                        onTap: () {},
                        child: const CircleAvatar(
                          radius: 20,
                          backgroundColor: AppColors.lightBlue,
                          child: Icon(
                            Icons.person,
                            color: AppColors.black,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Text(
                    "Surulere, Lagos.",
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      fontFamily: AppFonts.gtWalshPro,
                      height: 1.3,
                      color: AppColors.par,
                    ),
                  ),
                  Wrap(
                    direction: Axis.horizontal,
                    children: [
                      ..._tabs.map(
                        (tab) => Container(
                          margin: const EdgeInsets.all(5),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 5),
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
            const Divider(color: AppColors.grey),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text(
                    "Recreational Centers Near You",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      fontFamily: AppFonts.gtWalshPro,
                      height: 1.3,
                      color: AppColors.black,
                    ),
                  ),
                  CardView(iconFav: Icon(Icons.favorite))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
