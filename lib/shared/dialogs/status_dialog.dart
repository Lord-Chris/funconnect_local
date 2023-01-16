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
        padding: EdgeInsets.all(53.r),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(36),
          color: AppColors.interestWidgetAsh,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isError ? Icons.error : CupertinoIcons.check_mark_circled_solid,
              color: isError ? AppColors.primary : AppColors.notificationGreen,
              size: 123.sp,
            ),
            SizedBox(height: 31.h),
            Text(
              title,
              textAlign: TextAlign.center,
              style: AppTextStyles.medium24,
            ),
            SizedBox(height: 16.h),
            Flexible(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: AppTextStyles.light14.copyWith(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
