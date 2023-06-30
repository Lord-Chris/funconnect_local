import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:funconnect/features/places/domain/entities/home_category_data.dart';
import 'package:funconnect/features/places/presentation/blocs/home_v2_bloc/home_v2_bloc.dart';

class HomeCategoryContainer extends StatelessWidget {
  final HomeCategoryData category;
  const HomeCategoryContainer({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<HomeV2Bloc>().add(CategoryTapEvent(category: category));
      },
      child: SizedBox(
        width: 136.w,
        height: 136,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.r),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Positioned(
                top: 0,
                bottom: 0,
                right: 0,
                left: 0,
                child: FancyShimmerImage(
                  imageUrl: category.coverPhoto,
                  boxFit: BoxFit.fill,
                ),
              ),
              Positioned(
                  bottom: 8,
                  left: 0,
                  right: 0,
                  child: Align(
                      alignment: Alignment.center,
                      child: Container(
                          decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(20.r)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12.0, vertical: 8),
                            child: Text(category.name),
                          ))))
            ],
          ),
        ),
      ),
    );
  }
}
