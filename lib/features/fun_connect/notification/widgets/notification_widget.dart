import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../shared/constants/_constants.dart';
import '../../../../shared/dumb_widgets/dumb_app_strings.dart';

class NotificationWidget extends StatelessWidget {
  bool hasButton;
  bool read;
  NotificationWidget({
    required this.hasButton,
    required this.read,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.0.h),
      child: Container(
        height: 75.0.h,
        decoration: BoxDecoration(
          color: AppColors.notificationWidgetBlack,
          borderRadius: BorderRadius.circular(8.0.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CircleAvatar(
              radius: 5.0.r,
              backgroundColor:
                  read ? AppColors.notificationGreen : AppColors.red,
            ),
            const CircleAvatar(),
            RichText(
              textAlign: TextAlign.start,
              text: TextSpan(
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  fontFamily: AppFonts.gtWalshPro,
                  color: AppColors.primary,
                ),
                children: [
                  TextSpan(
                    text: DumbAppStrings.notificationMainText,
                    style: AppTextStyles.medium12,
                  ),
                  TextSpan(
                    text: DumbAppStrings.notificationSubMainText,
                    style: AppTextStyles.medium12.copyWith(
                      color: AppColors.primary,
                    ),
                    recognizer: TapGestureRecognizer()..onTap = () {},
                  ),
                ],
              ),
            ),
            hasButton
                ? Container(
                    width: 54.0.w,
                    height: 30.0.h,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(6.0.r),
                    ),
                    child: SizedBox(
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          DumbAppStrings.notificationButtonText,
                          style: AppTextStyles.medium12.copyWith(fontSize: 7.0),
                        ),
                      ),
                    ),
                  )
                : SizedBox(
                    width: 54.0.w,
                    height: 24.0.h,
                  ),
          ],
        ),
      ),
    );
  }
}
