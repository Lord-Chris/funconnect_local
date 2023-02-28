import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:funconnect/shared/components/custom_button.dart';
import 'package:funconnect/shared/constants/_constants.dart';

import '../../../../core/utils/general_utils.dart';

class VersionUpdateView extends StatelessWidget {
  const VersionUpdateView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(44),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Version Update!",
                textAlign: TextAlign.center,
                style: AppTextStyles.medium24,
              ),
              Expanded(
                child: SvgPicture.asset(AppAssets.updateSvg),
              ),
              Text(
                "New update available",
                textAlign: TextAlign.center,
                style: AppTextStyles.medium20,
              ),
              Spacing.vertRegular(),
              Text(
                "Update your app to the latest version with improved performance and exciting new features to enhance your user experience.",
                textAlign: TextAlign.center,
                style: AppTextStyles.regular16.copyWith(
                  color: AppColors.gray97,
                ),
              ),
              Spacing.vertExtraLarge(),
              AppButton(
                label: "Update App",
                labelColor: AppColors.black,
                onTap: () async => await GeneralUtils.updateApp(),
              ),
              Spacing.vertMedium(),
              // Text(
              //   "I'll do it later",
              //   textAlign: TextAlign.center,
              //   style: AppTextStyles.regular16,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
