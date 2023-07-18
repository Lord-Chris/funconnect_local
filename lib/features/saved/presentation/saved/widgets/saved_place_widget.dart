import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../shared/components/_components.dart';
import '../../../../../shared/constants/_constants.dart';

class SavedPlaceWidget extends HookWidget {
  final String name;
  final bool isBookmarked;

  final String coverImage;
  final Size? size;
  final VoidCallback? onTap;

  const SavedPlaceWidget({
    Key? key,
    required this.name,
    required this.isBookmarked,
    required this.coverImage,
    this.size,
    this.onTap,
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
                ),
              ),
              Positioned.fill(
                child: Container(
                  padding: EdgeInsets.all(4.r),
                  alignment: Alignment.bottomCenter,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          width: 24.w,
                          height: 24.h,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.black,
                          ),
                          child: Center(
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
                        ),
                      ),
                      const Spacer(),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(8.r),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(15.r),
                        ),
                        child: Text(
                          name,
                          style: AppTextStyles.regular14,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
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
