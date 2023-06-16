import 'dart:async';

import 'package:funconnect/core/app/locator.dart';
import 'package:funconnect/core/constants/_constants.dart';
import 'package:funconnect/core/models/_models.dart';
import 'package:funconnect/services/local_storage_service/i_local_storage_service.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:logger/logger.dart';

import 'i_location_service.dart';

class IosLocationService extends ILocationService {
  final _logger = Logger();
  AppLocation? _location;
  final _localStorageService = locator<ILocalStorageService>();
  DateTime? _locationTimeStamp;

  @override
  Future<bool> canGetLocation() async {
    final res = await Geolocator.checkPermission();
    return res == LocationPermission.always ||
        res == LocationPermission.whileInUse;
  }

  @override
  Future<AppLocation?> getCurrentLocation() async {
    try {
      /// Check if the location was fetched more than 30 mins ago. If it was
      /// return the saved location, else fetch the location afresh.
      if (_locationTimeStamp != null && _location != null) {
        if (DateTime.now().difference(_locationTimeStamp!).inMinutes < 30) {
          return AppLocation.fromMap(_localStorageService.read(
            HiveKeys.appBoxId,
            key: StorageKeys.userSavedLocation,
          ));
        }
      }

      final hasPermission = await requestPermission();

      if (!hasPermission) {
        throw const Failure("Application requires location access");
      }

      Position? res;
      try {
        _logger.i("Getting current location");
        res = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best,
          timeLimit: const Duration(seconds: 5),
        );
      } on LocationServiceDisabledException {
        _logger.i("Getting Last location from Hive");
        _location = AppLocation.fromMap(_localStorageService.read(
          HiveKeys.appBoxId,
          key: StorageKeys.userSavedLocation,
        ));

        _logger.i("Received location from Hive is $_location");
        return _location;
      } on TimeoutException {
        _logger.i("Getting Last known location");
        res = await Geolocator.getLastKnownPosition();
        _logger.i("Last known location is $res");
      }
      if (res == null) return null;
      _logger.d(res);
      _logger.i("Getting place details");
      final place = await placemarkFromCoordinates(res.latitude, res.longitude);
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
      await _localStorageService.write(
        HiveKeys.appBoxId,
        key: StorageKeys.userSavedLocation,
        data: _location!.toMap(),
      );
      _locationTimeStamp = DateTime.now();
      return _location;
    } on Exception catch (e) {
      _logger.e(e);
      throw Failure("Unable to get location", extraData: e.toString());
    }
  }

  @override
  Future<bool> requestPermission() async {
    try {
      final locationAllowed = await canGetLocation();
      if (locationAllowed) return true;
      final res = await Geolocator.requestPermission();
      return res == LocationPermission.always ||
          res == LocationPermission.whileInUse;
    } on Exception catch (e) {
      _logger.e(e);
      return false;
    }
  }

  @override
  AppLocation? get userLocation => _location;

  @override
  DateTime? get locationTimeStamp => _locationTimeStamp;
}
