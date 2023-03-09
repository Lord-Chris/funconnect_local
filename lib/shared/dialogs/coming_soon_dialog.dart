import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:funconnect/shared/components/custom_button.dart';

import '../constants/_constants.dart';

class ComingSoonDialog extends StatelessWidget {
  final String icon;
  final String label;
  const ComingSoonDialog({
    Key? key,
    required this.icon,
    required this.label,
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
            SvgPicture.asset(
              icon,
              height: 100.sp,
            ),
            Spacing.vertRegular(),
            Text(
              label,
              textAlign: TextAlign.center,
              style: AppTextStyles.regular16,
            ),
            Spacing.vertExtraMedium(),
            Text(
              "Coming Soon!",
              textAlign: TextAlign.center,
              style: AppTextStyles.medium24,
            ),
            Spacing.vertRegular(),
            Flexible(
              child: Text(
                "You will recieve a notification when we launch.",
                textAlign: TextAlign.center,
                style: AppTextStyles.light14.copyWith(),
              ),
            ),
            Spacing.vertExtraMedium(),
            AppButton(
              label: "Go back",
              labelColor: AppColors.black,
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}
