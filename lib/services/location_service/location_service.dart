import 'dart:async';

import 'package:funconnect/core/models/_models.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:logger/logger.dart';

import 'i_location_service.dart';

class LocationService extends ILocationService {
  final _logger = Logger();
  AppLocation? _location;

  @override
  Future<bool> canGetLocation() async {
    final res = await Geolocator.checkPermission();
    return res == LocationPermission.always ||
        res == LocationPermission.whileInUse;
  }

  @override
  Future<AppLocation?> getCurrentLocation() async {
    try {
      final hasPermission = await requestPermission();
      if (!hasPermission) {
        throw const Failure("Application requires location access");
      }
      Position? res;
      try {
        _logger.i("Getting current location");
        res = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best,
          timeLimit: const Duration(seconds: 10),
        );
      } on TimeoutException {
        _logger.i("Getting Last known location");
        res = await Geolocator.getLastKnownPosition();
      }
      if (res == null) return null;
      _logger.i("Getting place details");
      final place = await placemarkFromCoordinates(res.latitude, res.longitude);
      _logger.i(res);
      if (place.isEmpty) {
        _location = AppLocation(lat: res.latitude, long: res.longitude);
      } else {
        _location = AppLocation(
          lat: res.latitude,
          long: res.longitude,
          address: "${place.first.name} ${place.first.thoroughfare}",
          city: place.first.locality,
          state: place.first.administrativeArea,
          country: place.first.country,
        );
      }
      return _location;
    } on Exception catch (e) {
      throw Failure("Unable to get location", extraData: e.toString());
    }
  }

  @override
  Future<bool> requestPermission() async {
    final locationAllowed = await canGetLocation();
    if (locationAllowed) return true;
    final res = await Geolocator.requestPermission();
    return res == LocationPermission.always ||
        res == LocationPermission.whileInUse;
  }

  @override
  AppLocation? get userLocation => _location;
}
