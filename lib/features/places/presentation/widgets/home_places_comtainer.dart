import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:funconnect/features/places/domain/entities/home_places_data.dart';

class HomePlaceContainer extends StatelessWidget {
  final HomePlacesData place;
  const HomePlaceContainer({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 187.w,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.r),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Positioned(
              top: 0,
              bottom: 0,
              right: 0,
              left: 0,
              child: FancyShimmerImage(
                imageUrl: place.coverImagePath,
                boxFit: BoxFit.fill,
              ),
            ),
            Positioned(
                bottom: 0,
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
                          child: Text(place.name),
                        ))))
          ],
        ),
      ),
    );
  }
}
