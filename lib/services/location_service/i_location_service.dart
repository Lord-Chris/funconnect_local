import 'package:funconnect/core/models/app_location.dart';

abstract class ILocationService {
  Future<bool> canGetLocation();
  Future<bool> requestPermission();
  Future<AppLocation?> getCurrentLocation();

  AppLocation? get userLocation;
}
