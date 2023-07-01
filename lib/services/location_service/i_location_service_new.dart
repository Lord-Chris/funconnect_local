import 'package:geolocator/geolocator.dart';

abstract class ILocationServiceNew {
  Future<Position> determinePosition();
}
