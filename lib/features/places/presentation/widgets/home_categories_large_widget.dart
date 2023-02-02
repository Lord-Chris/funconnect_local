import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:funconnect/features/places/presentation/blocs/home_bloc/home_bloc.dart';
import 'package:funconnect/features/places/presentation/blocs/home_bloc/home_event.dart';

import '../../../../shared/constants/_constants.dart';

class HomeCategoriesLargeWidget extends StatelessWidget {
  const HomeCategoriesLargeWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.read<HomeBloc>().add(PlaceTapEvent()),
      child: Container(
        height: 182.r,
        width: 182.r,
        padding: EdgeInsets.all(4.r),
        alignment: Alignment.bottomCenter,
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(18),
          image: const DecorationImage(
            fit: BoxFit.cover,
            image: CachedNetworkImageProvider(
              AppConstants.mockImage,
            ),
          ),
        ),
        child: Container(
          padding: EdgeInsets.all(11.r),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.7),
            borderRadius: BorderRadius.circular(15.r),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      DumbAppStrings.bestForYouLabel,
                      style: AppTextStyles.regular14,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 1),
                    child: const Icon(
                      CupertinoIcons.bookmark,
                      color: AppColors.white,
                      size: 15,
                    ),
                  ),
                ],
              ),
              Spacing.vertTiny(),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    DumbAppStrings.ratingLabel,
                    style: AppTextStyles.dynamic(
                      10,
                      weight: FontWeight.w300,
                    ),
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
                          size: 10.0,
                        ),
                        starSize: 10,
                        starCount: 5,
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
                    DumbAppStrings.ratiedLabel,
                    style: AppTextStyles.dynamic(
                      10,
                      weight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
