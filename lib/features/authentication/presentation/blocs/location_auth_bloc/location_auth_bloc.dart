import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:funconnect/core/app/_app.dart';
import 'package:funconnect/features/authentication/presentation/blocs/location_auth_bloc/location_auth_event.dart';
import 'package:funconnect/features/authentication/presentation/blocs/location_auth_bloc/location_auth_state.dart';
import 'package:funconnect/services/_services.dart';
import 'package:location/location.dart';

class LocationAuthBloc extends Bloc<LocationAuthEvent, LocationAuthState> {
  LocationAuthBloc() : super(LocationAuthInitialState()) {
    on<RequestLocationPermissionEvent>(_onRequestLocationPermissionEvent);
    on<NotNowTapEvent>(_onNotNowTapEvent);
  }

  final _navigationService = locator<INavigationService>();

  Future<FutureOr<void>> _onRequestLocationPermissionEvent(
    RequestLocationPermissionEvent event,
    Emitter<LocationAuthState> emit,
  ) async {
    try {
      await _getLocation();
      emit(LocationAuthSuccessState());
      _navigationService.toNamed(Routes.dashboardViewRoute);
    } catch (e) {
      // TODO: Change to Failure catching
      emit(LocationAuthErrorState());
    }
  }

  FutureOr<void> _onNotNowTapEvent(
    NotNowTapEvent event,
    Emitter<LocationAuthState> emit,
  ) {}

  Future<void> _getLocation() async {
    Location location = Location();
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    // LocationData locationData;

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
