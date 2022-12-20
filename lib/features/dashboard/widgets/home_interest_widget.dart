import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/presentation/widgets/app_spacer.dart';
import '../../../shared/constants/_constants.dart';

class HomeInterestWidget extends StatelessWidget {
  const HomeInterestWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50.0),
          color: AppColors.interestWidgetAsh),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const CircleAvatar(
              radius: 15.0,
            ),
            AppSpacer.normalWeightSpace,
            Text(
              "Fine dining",
              style: AppTextStyles.whitelight,
            ),
          ],
        ),
      ),
    );
  }
}
