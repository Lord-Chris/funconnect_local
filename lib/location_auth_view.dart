import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:funconnect/constants/custom_button.dart';
import 'package:funconnect/shared/constants/_constants.dart';
import 'package:location/location.dart';

class LocationAuthenticationView extends StatefulWidget {
  const LocationAuthenticationView({Key? key}) : super(key: key);

  @override
  State<LocationAuthenticationView> createState() => _LocationAuthenticationViewState();
}

class _LocationAuthenticationViewState extends State<LocationAuthenticationView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * 0.048,
            right: MediaQuery.of(context).size.width * 0.048,
            top: MediaQuery.of(context).size.width * 0.05,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SvgPicture.asset("assets/icons/small_logo.svg"),
              const SizedBox(
                height: 35,
              ),
              const Text(
                "Easily Find Nearby Fun centers and important spots near you.",
                style: TextStyle(
                  color: AppColors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  height: 1.3,
                  fontFamily: AppFonts.merriweather,
                  fontStyle: FontStyle.normal,
                ),
              ),
              const Spacer(),
              CustomButton(
                text: "Allow location data",
                textColor: Colors.white,
                buttonColor: AppColors.primary,
                function: () async {
                  await _getLocation();
                },
              ),
              const SizedBox(
                height: 16,
              ),
              const Center(
                child: Text(
                  "Not now",
                  style: TextStyle(
                    color: AppColors.secondary,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    height: 1.3,
                    fontFamily: AppFonts.gtWalshPro,
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ),
              const SizedBox(
                height: 67,
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _getLocation() async {
    Location location = Location();
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    // var currentLocation = await location.getLocation();
    // locationData = await location.getLocation();
    // String loc = currentLocation.latitude.toString();
  }
}
