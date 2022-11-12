import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:funconnect/core/presentation/widgets/app_black_modal.dart';

import '../../../../core/presentation/widgets/app_orange_button.dart';
import '../../../../shared/constants/app_textStyle.dart';
import '../../../../shared/constants/colors.dart';
import '../../../../shared/constants/fonts.dart';

class EmailVerifiedScreen extends StatelessWidget {
  const EmailVerifiedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AppBlackModalWidget(
      imageContainerHeight: 400.0,
      modalHeight: 350,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Email ID verified!",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: AppFonts.merriweather,
                color: AppColors.white,
              ),
            ),
            Text("Your email has been verified successfully.",
                textAlign: TextAlign.center, style: AppTextStyle.WhiteMedium),
            const SizedBox(height: 62),
            App_Orange_Btn(
              label: "Continue",
            ),
          ],
        ),
      ],
    ));
  }
}
