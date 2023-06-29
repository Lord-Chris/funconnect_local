import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:funconnect/features/places/domain/entities/home_category_data.dart';

class HomeCategoryContainer extends StatelessWidget {
  final HomeCategoryData category;
  const HomeCategoryContainer({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150.h,
      decoration: BoxDecoration(
          color: Colors.red, borderRadius: BorderRadius.circular(50.r)),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            top: 0,
            bottom: 0,
            right: 0,
            left: 0,
            child: CachedNetworkImage(
              imageUrl: category.coverPhoto,
              fit: BoxFit.fill,
            ),
          ),
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Align(
                  alignment: Alignment.center, child: Text(category.name)))
        ],
      ),
    );
  }
}
