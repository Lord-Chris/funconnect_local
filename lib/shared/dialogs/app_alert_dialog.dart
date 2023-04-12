import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:funconnect/shared/components/_components.dart';
import 'package:funconnect/shared/constants/app_spacer.dart';
import 'package:funconnect/shared/constants/colors.dart';
import 'package:funconnect/shared/constants/textstyles.dart';

class AppAlertDialog extends StatelessWidget {
  final bool isHighPriority;
  final String title;
  final String body;
  final String positiveLabel;
  final String negativeLabel;
  final VoidCallback positiveCallBack;
  final VoidCallback negativeCallBack;

  const AppAlertDialog({
    Key? key,
    required this.isHighPriority,
    required this.title,
    required this.body,
    required this.positiveLabel,
    required this.negativeLabel,
    required this.positiveCallBack,
    required this.negativeCallBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(36),
      ),
      child: Container(
        padding: EdgeInsets.all(40.r),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(36),
          color: AppColors.interestWidgetAsh,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: AppTextStyles.bold24,
            ),
            Spacing.vertRegular(),
            Flexible(
              child: Text(
                body,
                textAlign: TextAlign.center,
                style: AppTextStyles.light14.copyWith(),
              ),
            ),
            Spacing.vertRegular(),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: negativeCallBack,
                    child: Text(negativeLabel),
                  ),
                ),
                Spacing.horizRegular(),
                Expanded(
                  child: AppButton(
                    onTap: positiveCallBack,
                    label: positiveLabel,
                    // isCollapsed: true,

                    buttonColor: isHighPriority
                        ? AppColors.deleteTextRed
                        : AppColors.primary,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
