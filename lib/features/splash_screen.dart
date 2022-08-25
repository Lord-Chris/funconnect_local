import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:funconnect/constants/colors.dart';
import 'package:funconnect/constants/fonts.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/splash';

  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: AppColors.primary,
          child: Column(
            children: [
              Stack(
                alignment: AlignmentDirectional.topCenter,
                children: [
                  Positioned(
                    child: SvgPicture.asset(
                      "assets/images/splash_up_curve.svg",
                      width: 331,
                      height: 331,
                    ),
                  )
                ],
              ),
              const Spacer(),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    "assets/icons/funconnect_logo.svg",
                    width: 136,
                    height: 24,
                  ),
                ],
              ),
              const Spacer(),
              Stack(
                children: [
                  SvgPicture.asset(
                    "assets/images/splash_down_curve.svg",
                    width: 331,
                    height: 331,
                  ),
                  const Positioned(
                    bottom: 40,
                    left: 180,
                    child: Text(
                      "Funconnect Technologies",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        height: 1.3,
                        fontFamily: AppFonts.gtWalshPro,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
