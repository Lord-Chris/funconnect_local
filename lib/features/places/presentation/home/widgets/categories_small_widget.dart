import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../shared/components/_components.dart';
import '../../../../../shared/constants/_constants.dart';

class HomeViewCategoriesSmallSubWidget extends HookWidget {
  final String name;
  final String coverImage;
  final VoidCallback? onTap;

  const HomeViewCategoriesSmallSubWidget({
    Key? key,
    required this.name,
    required this.coverImage,
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
          height: 136.r,
          width: 136.r,
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
              Container(
                height: 136.r,
                width: 136.r,
                padding: EdgeInsets.all(4.r),
                alignment: Alignment.bottomLeft,
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
                        padding:
                            REdgeInsets.symmetric(vertical: 4, horizontal: 12),
                        child: Text(
                          name,
                          style: AppTextStyles.regular12,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
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
