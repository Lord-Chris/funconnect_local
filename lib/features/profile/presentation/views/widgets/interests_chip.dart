import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:funconnect/shared/constants/app_assets.dart';
import 'package:funconnect/shared/constants/colors.dart';
import 'package:funconnect/shared/constants/textstyles.dart';

class InterestsChip extends StatelessWidget {
  final String title;
  final VoidCallback onSelect;
  final bool isSelected;
  const InterestsChip(
      {Key? key,
      required this.title,
      required this.onSelect,
      this.isSelected = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.h),
          border: Border.all(color: AppColors.locationIconAsh)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            AppAssets.add,
            height: 9,
          ),
          const SizedBox(
            width: 6,
          ),
          Text(
            title,
            style: AppTextStyles.medium10
                .copyWith(color: AppColors.locationIconAsh),
          ),
        ],
      ),
    );
  }
}
