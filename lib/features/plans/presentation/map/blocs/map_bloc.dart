import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:funconnect/features/places/domain/entities/full_place_model.dart';
import 'package:funconnect/features/places/domain/entities/home_response_data.dart';
import 'package:funconnect/features/places/domain/usecases/fetch_place_detail.dart';
import 'package:funconnect/shared/constants/colors.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  MapBloc() : super(MapInitial()) {
    on<MapEvent>((event, emit) {});
  }

  Future<Set<Marker>> generateMarkers(
      HomeResponseData data, BuildContext context) async {
    List<Marker> markers = [];

    for (var place in data.places[0].data) {
      final data = await FetchPlaceDetail().call(place.id);
      final fullPlace = data[0] as FullPlaceModel;

      markers.add(Marker(
        onTap: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return Container(
                decoration: const BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Wrap(
                  children: [
                    Column(
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10)),
                              color: Colors.black),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 27, horizontal: 15),
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      fullPlace.name,
                                      style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Text(fullPlace.location?.city ?? "",
                                        style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w400)),
                                  ],
                                ),
                                const Expanded(child: SizedBox()),
                                Container(
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(8),
                                    ),
                                    color: AppColors.primary,
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 8.0, horizontal: 16),
                                    child: Text(
                                      "Add to plan",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Container(
                          decoration: const BoxDecoration(color: Colors.white),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 6.0, horizontal: 15),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    fullPlace.location?.address ?? "",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Starting NGN 5,000",
                                        style: TextStyle(
                                            color: AppColors.secondary400,
                                            fontSize: 10.sp,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      const Expanded(
                                        child: SizedBox(),
                                      ),
                                      Text("${fullPlace.reviewsAvgRating}",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 10.sp,
                                              fontWeight: FontWeight.w400)),
                                      SizedBox(
                                        width: 5.w,
                                      ),
                                      RatingBarIndicator(
                                        direction: Axis.horizontal,
                                        rating: fullPlace.reviewsAvgRating ?? 0,
                                        itemCount: 5,
                                        itemSize: 12.sp,
                                        unratedColor: AppColors.secondary400,
                                        itemPadding: const EdgeInsets.symmetric(
                                            horizontal: 0),
                                        itemBuilder: (context, _) => const Icon(
                                          Icons.star,
                                          color: AppColors.primary,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5.w,
                                      ),
                                      Text("(${fullPlace.reviewsCount})",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 10.sp,
                                              fontWeight: FontWeight.w400))
                                    ],
                                  )
                                ]),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        },
        markerId: MarkerId(place.id),
        position: LatLng(double.parse(fullPlace.location!.lat),
            double.parse(fullPlace.location!.long)),
        infoWindow: InfoWindow(
          title: fullPlace.name,
          snippet: fullPlace.address,
        ),
      ));
    }

    return markers.toSet();
  }
}
