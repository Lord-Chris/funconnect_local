import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:funconnect/shared/constants/colors.dart';
import 'package:funconnect/shared/constants/textstyles.dart';

class StatusDialog extends StatelessWidget {
  final bool isError;
  final String title;
  final String body;

  const StatusDialog({
    Key? key,
    required this.isError,
    required this.title,
    required this.body,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(36),
      ),
      child: Container(
        padding: REdgeInsets.symmetric(horizontal: 40, vertical: 60),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(36),
          color: Theme.of(context).brightness == Brightness.light
              ? AppColors.white
              : AppColors.interestWidgetAsh,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isError ? Icons.error : CupertinoIcons.check_mark_circled_solid,
              color: isError ? AppColors.primary : AppColors.notificationGreen,
              size: 100.sp,
            ),
            SizedBox(height: 31.h),
            Text(title,
                textAlign: TextAlign.center,
                style: AppTextStyles.medium20.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                )),
            SizedBox(height: 16.h),
            Flexible(
              child: Text(
                body,
                textAlign: TextAlign.center,
                style: AppTextStyles.light14.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
