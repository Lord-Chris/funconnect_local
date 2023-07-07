import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletons/skeletons.dart';

class HomeSkeleton extends StatelessWidget {
  const HomeSkeleton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(8.h),
      children: [
        const SkeletonCategoryHeading(),
        SizedBox(height: 10.h),
        const SkeletonCategoryItems(
          width: 125,
        ),
        SizedBox(height: 10.h),
        const SkeletonCategoryHeading(),
        SizedBox(height: 10.h),
        const SkeletonCategoryItems(
          width: 175,
        ),
        SizedBox(height: 10.h),
        const SkeletonCategoryHeading(),
        SizedBox(height: 10.h),
        const SkeletonCategoryItems(
          width: 175,
        ),
        SizedBox(height: 10.h),
        const SkeletonCategoryHeading(),
        SizedBox(height: 10.h),
        const SkeletonCategoryItems(
          width: 175,
        ),
      ],
    );
  }
}

class SkeletonCategoryItems extends StatelessWidget {
  final int width;
  const SkeletonCategoryItems({
    super.key,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 200.r,
        child: ListView.separated(
          separatorBuilder: (context, index) {
            return SizedBox(width: 10.w);
          },
          scrollDirection: Axis.horizontal,
          itemCount: 5,
          padding: EdgeInsets.all(8.r),
          itemBuilder: (context, index) {
            return SkeletonAvatar(
              style: SkeletonAvatarStyle(
                width: width.w,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(10.r),
              ),
            );
          },
        ));
  }
}

class SkeletonCategoryHeading extends StatelessWidget {
  const SkeletonCategoryHeading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        SkeletonLine(
          style: SkeletonLineStyle(
            width: 200.w,
            height: 30.h,
            borderRadius: BorderRadius.circular(10.r),
          ),
        ),
        SkeletonLine(
          style: SkeletonLineStyle(
            width: 100.w,
            height: 15.h,
            borderRadius: BorderRadius.circular(10.r),
          ),
        ),
      ],
    );
  }
}
