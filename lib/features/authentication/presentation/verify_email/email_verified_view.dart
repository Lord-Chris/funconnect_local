import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:funconnect/core/app/_app.dart';
import 'package:funconnect/core/models/user_model.dart';
import 'package:funconnect/services/_services.dart';
import 'package:funconnect/shared/constants/_constants.dart';

import '../../../../core/enums/_enums.dart';
import '../../../../shared/components/app_black_modal.dart';
import '../../../../shared/components/app_orange_button.dart';

class EmailVerifiedScreen extends StatelessWidget {
  final UserModel user;
  const EmailVerifiedScreen({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        top: false,
        child: AppBlackModalWidget(
          modalHeight: MediaQuery.of(context).size.height,
          showBackButton: true,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Spacing.vertLarge(),
                Container(
                  height: 124.sp,
                  width: 124.sp,
                  decoration: const BoxDecoration(
                    color: AppColors.green,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    CupertinoIcons.check_mark,
                    size: 50.sp,
                    color: AppColors.white,
                  ),
                ),
                Spacing.vertRegular(),
                Text(
                  AppText.aTAuthEmailIDVerificationText,
                  style: AppTextStyles.medium24,
                ),
                Spacing.vertSmall(),
                Text(
                  AppText.aTAuthEmailIDVerificationSuccessText,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.regular14,
                ),
                const SizedBox(height: 62),
                AppOrangeBtn(
                  label: AppText.aTAuthContinueText,
                  onTap: () {
                    if (user.status == UserStatus.NEW_USER) {
                      locator<INavigationService>().offNamed(
                        Routes.profileSetupViewRoute,
                        arguments: user,
                      );
                    } else {
                      locator<INavigationService>().offAllNamed(
                        Routes.dashboardViewRoute,
                        (_) => false,
                      );
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
