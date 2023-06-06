import 'dart:async';

import 'package:funconnect/core/app/locator.dart';
import 'package:funconnect/core/models/_models.dart';
import 'package:funconnect/services/local_storage_service/i_local_storage_service.dart';
import 'package:geocoding/geocoding.dart' hide Location;
import 'package:location/location.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:logger/logger.dart';

import '../../core/constants/_constants.dart';
import 'i_location_service.dart';

class LocationService extends ILocationService {
  final _logger = Logger();
  AppLocation? _location;
  final _localStorageService = locator<ILocalStorageService>();
  Location location = Location();

  @override
  Future<bool> canGetLocation() async {
    final permission = await location.hasPermission();
    return permission == PermissionStatus.granted ||
        permission == PermissionStatus.grantedLimited;
  }

  @override
  Future<AppLocation?> getCurrentLocation() async {
    try {
      final hasPermission = await requestPermission();

      if (!hasPermission) {
        throw const Failure("Application requires location access");
      }

      LocationData? res;
      _logger.i("Getting current location");
      res = await location.getLocation();
      // .timeout(Duration(seconds: Platform.isAndroid ? 5 : 10));
      if (res.latitude == null || res.longitude == null) {
        _logger.i("Getting Last location from Hive");
        _location = AppLocation.fromMap(_localStorageService.read(
          HiveKeys.appBoxId,
          key: StorageKeys.userSavedLocation,
        ));
        _logger.i("Received location from Hive is $_location");
        return _location;
      } else {
        _logger.d(res);
        _logger.i("Getting place details");
        final place =
            await placemarkFromCoordinates(res.latitude!, res.longitude!);
        if (place.isEmpty) {
          _location = AppLocation(lat: res.latitude!, long: res.longitude!);
        } else {
          _location = AppLocation(
            lat: res.latitude!,
            long: res.longitude!,
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
        return _location;
      }
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
      final res = await location.requestPermission();
      return res == PermissionStatus.granted ||
          res == PermissionStatus.grantedLimited;
    } on Exception catch (e) {
      _logger.e(e);
      return false;
    }
  }

  @override
  AppLocation? get userLocation => _location;
}
