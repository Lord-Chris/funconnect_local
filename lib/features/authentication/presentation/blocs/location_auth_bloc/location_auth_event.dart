import 'package:equatable/equatable.dart';

abstract class LocationAuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class RequestLocationPermissionEvent extends LocationAuthEvent {}

class NotNowTapEvent extends LocationAuthEvent {}
