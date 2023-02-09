import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:funconnect/shared/components/_components.dart';
import 'package:funconnect/shared/constants/_constants.dart';

class PlaceDetailView extends StatelessWidget {
  const PlaceDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScrollableColumn(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppNetworkImage(
            size: Size.fromHeight(409.h),
            url: AppConstants.mockImage,
            borderRadius: 20,
            fit: BoxFit.cover,
          ),
          Spacing.vertRegular(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      "Leisure mall",
                      style: AppTextStyles.medium24,
                    ),
                  ),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 1),
                    child: const Icon(
                      CupertinoIcons.bookmark,
                      color: AppColors.white,
                      size: 20,
                    ),
                  ),
                ],
              ),
              Spacing.vertTiny(),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "4.8",
                    style: AppTextStyles.regular16,
                  ),
                  Spacing.horizExtraTiny(),
                  Flexible(
                    child: FittedBox(
                      child: RatingStars(
                        value: 3,
                        onValueChanged: (v) {},
                        starBuilder: (index, color) => Icon(
                          Icons.star,
                          color: color,
                          size: 14,
                        ),
                        starSize: 14,
                        starCount: 5,
                        starSpacing: 0,
                        maxValue: 5,
                        maxValueVisibility: false,
                        valueLabelVisibility: false,
                        animationDuration: const Duration(milliseconds: 1000),
                        starOffColor: AppColors.white,
                        starColor: AppColors.primary,
                      ),
                    ),
                  ),
                  Spacing.horizTiny(),
                  Text(
                    "(3.2k)",
                    style: AppTextStyles.regular16,
                  ),
                ],
              ),
              Spacing.vertMedium(),
              Text(
                "About",
                style: AppTextStyles.regular16,
              ),
              Spacing.vertSmall(),
              RichText(
                textScaleFactor: 1,
                text: TextSpan(
                  text:
                      'The mall house has numerous retail stores and outlets offering different types of products and services such as garments, food and beverages, electronics, and everything that is required in our day-to-day lives under a single roof. Hundreds of',
                  style: AppTextStyles.regular14.copyWith(
                    color: AppColors.white,
                  ),
                  children: [
                    TextSpan(
                      text: ' Read more.',
                      style: AppTextStyles.regular14.copyWith(
                        color: AppColors.primary,
                      ),
                    )
                  ],
                ),
              ),
              Spacing.vertRegular(),
              Text(
                "Features",
                style: AppTextStyles.regular16,
              ),
              Spacing.vertSmall(),
              RichText(
                textScaleFactor: 1,
                text: TextSpan(
                  text:
                      'Modern and sophisticated in its architecture, the self-styled \'Comprehensive Shopping Centre\' really delivers with its range of stores available from gadgets to gifts and',
                  style: AppTextStyles.regular14.copyWith(
                    color: AppColors.white,
                  ),
                  children: [
                    TextSpan(
                      text: ' Read more.',
                      style: AppTextStyles.regular14.copyWith(
                        color: AppColors.primary,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
