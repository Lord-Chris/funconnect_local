import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:funconnect/shared/dumb_widgets/dumb_app_strings.dart';

import '../../../../shared/constants/_constants.dart';

class HomeViewCategoriesSmallSubWidget extends StatelessWidget {
  const HomeViewCategoriesSmallSubWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 136.h,
      width: 136.w,
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: Padding(
        padding: EdgeInsets.only(top: 140.0.h, right: 24.0.w),
        child: Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0.r),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
              child: Container(
                height: 24.0.h,
                // width: 70.0.w,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(20.0.r),
                  border: Border.all(
                    width: 2.0.w,
                    color: AppColors.black.withOpacity(0.3),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      DumbAppStrings.categoriesLabel,
                      style: AppTextStyles.medium20,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
