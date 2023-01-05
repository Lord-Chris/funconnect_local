import 'package:funconnect/core/model/app_location.dart';
import 'package:funconnect/models/failure.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:logger/logger.dart';

import 'i_location_service.dart';

class LocationService extends ILocationService {
  final _logger = Logger();
  @override
  Future<bool> canGetLocation() async {
    final res = await Geolocator.checkPermission();
    return res == LocationPermission.always ||
        res == LocationPermission.whileInUse;
  }

  @override
  Future<AppLocation> getCurrentLocation() async {
    final hasPermission = await requestPermission();
    if (!hasPermission) {
      throw const Failure("Application requires location access");
    }
    _logger.i("Getting current location");
    final res = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
      forceAndroidLocationManager: true,
    );
    final place = await placemarkFromCoordinates(res.latitude, res.longitude);
    if (place.isEmpty) {
      return AppLocation(lat: res.latitude, long: res.longitude);
    }

    return AppLocation(
      lat: res.latitude,
      long: res.longitude,
      address: "${place.first.name} ${place.first.thoroughfare}",
      city: place.first.locality,
      state: place.first.administrativeArea,
      country: place.first.country,
    );
  }

  @override
  Future<bool> requestPermission() async {
    final locationAllowed = await canGetLocation();
    if (locationAllowed) return true;
    final res = await Geolocator.requestPermission();
    return res == LocationPermission.always ||
        res == LocationPermission.whileInUse;
  }
}
