import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../shared/constants/_constants.dart';

class HomeViewCategoriesWidget extends StatelessWidget {
  String label;
  Widget? child;
  double? height;
  HomeViewCategoriesWidget({
    this.child,
    this.height,
    required this.label,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 225.0.h,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 4.0.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  label,
                  style: AppTextStyles.whiteBold.copyWith(fontSize: 20.0),
                ),
                Text(
                  "See all",
                  style: AppTextStyles.whitelight.copyWith(fontSize: 14.0),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: EdgeInsets.only(right: 8.0.w),
                    child: child,
                  );
                }),
          ),
        ],
      ),
    );
  }
}
