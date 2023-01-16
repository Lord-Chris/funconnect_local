import 'package:flutter/material.dart';

import '../../../../core/presentation/widgets/app_orange_button.dart';
import '../../../../core/presentation/widgets/core_widgets.dart';
import '../../../../shared/constants/colors.dart';
import '../../../../shared/constants/fonts.dart';
import '../../../../shared/constants/textstyles.dart';

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
                AppText.aTAuthEmailIDVerificationText,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: AppFonts.merriweather,
                  color: AppColors.white,
                ),
              ),
              Text(AppText.aTAuthEmailIDVerificationSuccessText,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.whiteMedium),
              const SizedBox(height: 62),
              const AppOrangeBtn(
                label: AppText.aTAuthContinueText,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
