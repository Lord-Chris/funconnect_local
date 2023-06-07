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
        Row(
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
        ),
        SizedBox(height: 10.h),
        Row(
          children: [
            SkeletonAvatar(
              style: SkeletonAvatarStyle(
                width: 120.w,
                height: 120.h,
                shape: BoxShape.rectangle,
              ),
            ),
            SizedBox(width: 15.w),
            SkeletonAvatar(
              style: SkeletonAvatarStyle(
                width: 120.w,
                height: 120.h,
                shape: BoxShape.rectangle,
              ),
            ),
            SizedBox(width: 15.w),
            SkeletonAvatar(
              style: SkeletonAvatarStyle(
                width: 120.w,
                height: 120.h,
                shape: BoxShape.rectangle,
              ),
            ),
          ],
        ),
        SizedBox(height: 10.h),
        Row(
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
        ),
        SizedBox(height: 10.h),
        Row(
          children: [
            SkeletonAvatar(
              style: SkeletonAvatarStyle(
                width: 125.w,
                height: 160.h,
                shape: BoxShape.rectangle,
              ),
            ),
            SizedBox(width: 15.w),
            SkeletonAvatar(
              style: SkeletonAvatarStyle(
                width: 125.w,
                height: 160.h,
                shape: BoxShape.rectangle,
              ),
            ),
            SizedBox(width: 15.w),
            SkeletonAvatar(
              style: SkeletonAvatarStyle(
                width: 125.w,
                height: 160.h,
                shape: BoxShape.rectangle,
              ),
            ),
          ],
        ),
        SizedBox(height: 10.h),
        Row(
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
        ),
        SizedBox(height: 10.h),
        Row(
          children: [
            SkeletonAvatar(
              style: SkeletonAvatarStyle(
                width: 125.w,
                height: 160.h,
                shape: BoxShape.rectangle,
              ),
            ),
            SizedBox(width: 15.w),
            SkeletonAvatar(
              style: SkeletonAvatarStyle(
                width: 125.w,
                height: 160.h,
                shape: BoxShape.rectangle,
              ),
            ),
            SizedBox(width: 15.w),
            SkeletonAvatar(
              style: SkeletonAvatarStyle(
                width: 125.w,
                height: 160.h,
                shape: BoxShape.rectangle,
              ),
            ),
          ],
        ),
        SizedBox(height: 10.h),
        Row(
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
        ),
        SizedBox(height: 10.h),
        SkeletonParagraph(
          style: SkeletonParagraphStyle(
            lines: 3,
            spacing: 6,
            lineStyle: SkeletonLineStyle(
              randomLength: true,
              height: 10,
              borderRadius: BorderRadius.circular(8),
              minLength: MediaQuery.of(context).size.width / 6,
              maxLength: MediaQuery.of(context).size.width / 3,
            ),
          ),
        )
      ],
    );
  }
}
