import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../shared/constants/_constants.dart';
import '../../../shared/dumb_widgets/dumb_app_strings.dart';

class HomeCategoriesLargeWidget extends StatefulWidget {
  double? width;
  HomeCategoriesLargeWidget({
    this.width,
    Key? key,
  }) : super(key: key);

  @override
  State<HomeCategoriesLargeWidget> createState() =>
      _HomeCategoriesLargeWidgetState();
}

class _HomeCategoriesLargeWidgetState extends State<HomeCategoriesLargeWidget> {
  double value = 4.9;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300.0.h,
      // height: 30.0,
      width: widget.width ?? 170.0,
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(30.0.r),
      ),
      child: Padding(
        padding: EdgeInsets.only(bottom: 8.0.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Center(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0.r),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                  child: Container(
                    height: 90.0.h,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(20.0.r),
                      border: Border.all(
                        width: 2.0.w,
                        color: AppColors.black.withOpacity(0.3),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              DumbAppStrings.bestForYouLabel,
                              style: AppTextStyle.WhiteMedium,
                            ),
                            AnimatedContainer(
                              duration: Duration(milliseconds: 1),
                              child: const Icon(
                                Icons.bookmark_border,
                                color: AppColors.white,
                                size: 24.0,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              DumbAppStrings.ratingLabel,
                              style: AppTextStyle.WhiteMedium,
                            ),
                            // SimpleStarRating(
                            //   allowHalfRating: true,
                            //   starCount: 5,
                            //   rating: 3,
                            //   size: 32,
                            //   // allowHalfRating: true,
                            //   onRated: (rate) {},
                            //   spacing: 10,
                            // ),
                            // SmoothStarRating(
                            //   rating: value,
                            //   isReadOnly: false,
                            //   size: 80,
                            //   filledIconData: Icons.star,
                            //   halfFilledIconData: Icons.star_half,
                            //   defaultIconData: Icons.star_border,
                            //   starCount: 5,
                            //   allowHalfRating: true,
                            //   spacing: 2.0,
                            //   onRated: (value) {
                            //     print("rating value -> $value");
                            //     // print("rating value dd -> ${value.truncate()}");
                            //   },
                            // ),
                            // RatingStars(
                            //   value: value,
                            //   onValueChanged: (v) {
                            //     setState(() {
                            //       value = v;
                            //     });
                            //   },
                            //   starBuilder: (index, color) => Icon(
                            //     Icons.star,
                            //     color: color,
                            //     size: 10.0,
                            //   ),
                            //   starCount: 5,
                            //   // valueLabelColor: const Color(0xff9b9b9b),
                            //   // valueLabelTextStyle: const TextStyle(
                            //   //     color: Colors.white,
                            //   //     fontWeight: FontWeight.w400,
                            //   //     fontStyle: FontStyle.normal,
                            //   //     fontSize: 12.0),
                            //   // valueLabelRadius: 10,
                            //   maxValue: 5,
                            //   // starSpacing: -1,
                            //   maxValueVisibility: false,
                            //   valueLabelVisibility: false,
                            //   animationDuration: const Duration(milliseconds: 1000),
                            //   // valueLabelPadding: const EdgeInsets.symmetric(
                            //   //     vertical: 1, horizontal: 8),
                            //   // valueLabelMargin: const EdgeInsets.only(right: 8),
                            //   starOffColor: AppColors.white,
                            //   starColor: AppColors.primary,
                            // ),
                            Text(
                              DumbAppStrings.ratiedLabel,
                              style: AppTextStyle.Whitelight,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
