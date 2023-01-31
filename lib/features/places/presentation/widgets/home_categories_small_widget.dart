import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../shared/constants/_constants.dart';

class HomeViewCategoriesSmallSubWidget extends StatelessWidget {
  const HomeViewCategoriesSmallSubWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 136.r,
      width: 136.r,
      padding: EdgeInsets.all(4.r),
      alignment: Alignment.bottomLeft,
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
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0.r),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.7),
              borderRadius: BorderRadius.circular(56.r),
            ),
            child: Padding(
              padding: REdgeInsets.symmetric(vertical: 4, horizontal: 12),
              child: Text(
                "Art & Culture",
                style: AppTextStyles.regular12,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
