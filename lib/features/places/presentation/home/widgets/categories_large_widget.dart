import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:funconnect/shared/components/app_network_image.dart';

import '../../../../../shared/constants/_constants.dart';

class HomeCategoriesLargeWidget extends HookWidget {
  final String name;
  final bool isBookmarked;
  final double rating;
  final double ratingCount;
  final String coverImage;
  final Size? size;
  final VoidCallback? onTap;
  final VoidCallback? onBookmarkTap;
  final int showRatings;
  final bool cacheImage;

  const HomeCategoriesLargeWidget({
    Key? key,
    required this.name,
    required this.isBookmarked,
    required this.rating,
    required this.ratingCount,
    required this.coverImage,
    required this.showRatings,
    this.size,
    this.onTap,
    this.onBookmarkTap,
    this.cacheImage = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller =
        useAnimationController(duration: const Duration(milliseconds: 800));
    return InkWell(
      onTap: onTap,
      child: FadeTransition(
        opacity: Tween<double>(begin: 0, end: 1).animate(controller..forward()),
        child: SizedBox(
          height: (size?.height ?? 182).r,
          width: (size?.width ?? 182).r,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Positioned.fill(
                child: AppNetworkImage(
                  url: coverImage,
                  borderRadius: 18,
                  fit: BoxFit.cover,
                  cacheImage: cacheImage,
                ),
              ),
              Positioned.fill(
                child: Container(
                  padding: EdgeInsets.all(4.r),
                  alignment: Alignment.bottomCenter,
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
                                name,
                                style: AppTextStyles.regular14.copyWith(
                                  color: AppColors.white,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            InkWell(
                              onTap: onBookmarkTap,
                              child: Icon(
                                isBookmarked
                                    ? CupertinoIcons.bookmark_fill
                                    : CupertinoIcons.bookmark,
                                color: isBookmarked
                                    ? AppColors.primary
                                    : AppColors.white,
                                size: 15,
                              ),
                            ),
                          ],
                        ),
                        Spacing.vertTiny(),
                        showRatings > 0
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    rating.toString(),
                                    style: AppTextStyles.dynamic(
                                      10,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onBackground,
                                      weight: FontWeight.w300,
                                    ),
                                  ),
                                  Spacing.horizExtraTiny(),
                                  Flexible(
                                    child: FittedBox(
                                      child: RatingStars(
                                        value: rating,
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
                                        animationDuration:
                                            const Duration(milliseconds: 1000),
                                        starOffColor: AppColors.white,
                                        starColor: AppColors.primary,
                                      ),
                                    ),
                                  ),
                                  Spacing.horizTiny(),
                                  Text(
                                    ratingCount.toString(),
                                    style: AppTextStyles.dynamic(
                                      10,
                                      weight: FontWeight.w300,
                                    ),
                                  ),
                                ],
                              )
                            : const SizedBox(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
