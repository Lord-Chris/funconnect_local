import 'package:funconnect/core/model/app_location.dart';

abstract class ILocationService {
  Future<bool> canGetLocation();
  Future<bool> requestPermission();
  Future<AppLocation> getCurrentLocation();
}
