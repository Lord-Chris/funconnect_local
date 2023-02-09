import 'package:flutter/material.dart';
import 'package:funconnect/shared/constants/_constants.dart';

import '../../../../shared/components/app_orange_button.dart';
import '../widgets/app_black_modal.dart';

class EmailVerifiedScreen extends StatelessWidget {
  const EmailVerifiedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBlackModalWidget(
        imageContainerHeight: 300.0,
        modalHeight: 450,
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
              Text(
                AppText.aTAuthEmailIDVerificationSuccessText,
                textAlign: TextAlign.center,
                style: AppTextStyles.medium24,
              ),
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
