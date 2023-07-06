import 'package:funconnect/core/models/app_location.dart';

abstract class ILocationService {
  Future<bool> canGetLocation();
  Future<bool> requestPermission();
  Future<AppLocation?> getCurrentLocation();
  Future<bool> requestService();

  AppLocation? get userLocation;
  DateTime? get locationTimeStamp;
}
