import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:funconnect/shared/constants/colors.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlannerMapView extends StatelessWidget {
  const PlannerMapView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        GoogleMap(
          initialCameraPosition: const CameraPosition(
            target: LatLng(37.42796133580664, -122.085749655962),
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
          onMapCreated: (GoogleMapController controller) {
            // _controller.complete(controller);
          },
        ),
        Padding(
          padding: const EdgeInsets.only(top: 50.0, left: 16.0, right: 16.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 32.r,
                backgroundColor: Colors.white,
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                  size: 24,
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
                        padding: const EdgeInsets.symmetric(
                            vertical: 16.0, horizontal: 16.0),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.search,
                              color: Colors.black,
                              size: 24,
                            ),
                            SizedBox(width: 9.w),
                            const Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                    hintText: "Search",
                                    hintStyle:
                                        TextStyle(color: AppColors.gray333),
                                    border: InputBorder.none),
                              ),
                            ),
                            const Icon(
                              Icons.cancel,
                              color: Colors.black,
                              size: 24,
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
}
