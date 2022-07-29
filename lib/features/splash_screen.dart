import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:funconnect/constants/colors.dart';

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
    return SafeArea(
      child: Container(
        color: AppColors.primary,
        child: Column(
          children: [
            Column(
              children: [
                Stack(
                  alignment: AlignmentDirectional.topCenter,
                  children: [
                    Positioned(
                      child:
                          SvgPicture.asset("assets/images/splash_up_curve.svg"),
                    )
                  ],
                ),
              ],
            ),
            const Spacer(),
            Column(

              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "assets/icons/funconnect_logo.svg",
                ),
              ],
            ),
            const Spacer(),
            Column(
              children: [
                Align(
                  alignment: Alignment.bottomCenter,
                  child:
                      SvgPicture.asset("assets/images/splash_down_curve.svg"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

 
}
