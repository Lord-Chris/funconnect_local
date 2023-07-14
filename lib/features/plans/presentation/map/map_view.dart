import 'package:flutter/material.dart';
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
        Row(
          children: [
            Container(
              width: 48,
              height: 48,
              color: Colors.white,
              child: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
            ),
            Expanded(child: Container())
          ],
        ),
      ],
    ));
  }
}
