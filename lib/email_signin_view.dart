import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:funconnect/constants/colors.dart';
import 'package:funconnect/constants/custom_button.dart';
import 'package:funconnect/constants/fonts.dart';
import 'package:funconnect/constants/text_input.dart';

class EmailSigninView extends StatelessWidget {
  const EmailSigninView({Key? key}) : super(key: key);
  static const topCircle = "assets/svgs/ellipse_137.svg";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLight,
      body: Stack(
        fit: StackFit.loose,
        children: [
          Positioned(
            top: 0,
            right: 0,
            child: SvgPicture.asset(topCircle, width: 110),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                SizedBox(height: 30),
                Text(
                  "Authentication",
                  style: TextStyle(
                    fontSize: 24,
                    fontFamily: AppFonts.merriweather,
                    color: AppColors.text,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "Keep your data secured",
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: AppFonts.gtWalshPro,
                    color: AppColors.par,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                SizedBox(height: 78),
                AppTextField(
                  hint: "Your Email Address",
                ),
                SizedBox(height: 40),
                CustomButton(
                  text: "Get Code",
                  radius: 50,
                  textColor: AppColors.white,
                  buttonColor: AppColors.par,
                ),
                Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
