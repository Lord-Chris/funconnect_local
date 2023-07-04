import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:funconnect/features/places/domain/entities/home_places_data.dart';
import 'package:funconnect/features/places/presentation/blocs/home_v2_bloc/home_v2_bloc.dart';
import 'package:funconnect/shared/constants/colors.dart';

class HomePlaceContainer extends StatelessWidget {
  final HomePlacesData place;
  const HomePlaceContainer({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<HomeV2Bloc>().add(PlaceTapEvent(place: place));
      },
      child: Hero(
        tag: place.id,
        child: SizedBox(
          width: 187.w,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(18.r),
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
                    bottom: 8,
                    left: 0,
                    right: 0,
                    child: Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(56.r)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0, vertical: 8),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(child: Text(place.name)),
                                    place.savedPlace
                                        ? const Icon(Icons.bookmark,
                                            color: AppColors.primary)
                                        : const Icon(
                                            Icons.bookmark_border_rounded,
                                            color: AppColors.white)
                                  ],
                                ),
                              )),
                        )))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
