import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:funconnect/core/blocs/main_app_bloc.dart';
import 'package:funconnect/core/models/app_location.dart';
import 'package:funconnect/features/plans/presentation/blocs/map_bloc/map_bloc.dart';

import 'package:funconnect/shared/constants/colors.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlannerMapView extends StatelessWidget {
  const PlannerMapView({super.key});

  @override
  Widget build(BuildContext context) {
    AppLocation? currentLocation = context.watch<MainAppBloc>().location;
    return BlocBuilder<MainAppBloc, MainAppState>(
      builder: (context, state) {
        if (state is HomeTrendsLoadedState) {
          //create markers from the state value
          return Scaffold(
              body: Stack(
            children: [
              FutureBuilder(
                future: context
                    .read<MapBloc>()
                    .generateMarkers(state.homeTrends, context),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: LatLng(currentLocation?.lat ?? 37.42796133580664,
                          currentLocation?.long ?? -122.085749655962),
                      zoom: 14.4746,
                    ),
                    myLocationEnabled: true,
                    myLocationButtonEnabled: true,
                    mapType: MapType.normal,
                    zoomControlsEnabled: false,
                    zoomGesturesEnabled: true,
                    rotateGesturesEnabled: true,
                    scrollGesturesEnabled: true,
                    tiltGesturesEnabled: true,
                    compassEnabled: true,
                    indoorViewEnabled: true,
                    buildingsEnabled: true,
                    mapToolbarEnabled: true,
                    trafficEnabled: true,
                    markers: snapshot.data!,
                    onMapCreated: (GoogleMapController controller) {
                      // _controller.complete(controller);
                    },
                  );
                },
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 50.0, left: 16.0, right: 16.0),
                child: Row(
                  children: [
                    Container(
                      height: 48.h,
                      width: 48.w,
                      decoration: const BoxDecoration(
                          color: Colors.white, shape: BoxShape.circle),
                      child: const Center(
                        child: Icon(
                          Icons.arrow_back_sharp,
                          color: Colors.black,
                          size: 24,
                        ),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                        child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(40.r),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16.w,
                              ),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.search,
                                    color: Colors.black,
                                    size: 15,
                                  ),
                                  SizedBox(width: 9.w),
                                  const Expanded(
                                      child: TextField(
                                    decoration: InputDecoration(
                                        hintText: "Search",
                                        hintStyle:
                                            TextStyle(color: AppColors.gray333),
                                        border: InputBorder.none),
                                  )),
                                  const Icon(
                                    Icons.cancel,
                                    color: Colors.black,
                                    size: 13,
                                  ),
                                ],
                              ),
                            )))
                  ],
                ),
              ),
            ],
          ));
        }
        return Scaffold(
          body: Center(child: Text(state.toString())),
        );
      },
    );
  }
}
