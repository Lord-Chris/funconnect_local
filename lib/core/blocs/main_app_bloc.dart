import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:funconnect/core/app/locator.dart';
import 'package:funconnect/core/models/app_location.dart';
import 'package:funconnect/core/models/user_model.dart';
import 'package:funconnect/features/places/data/repository/i_place_repository.dart';
import 'package:funconnect/features/places/domain/entities/home_response_data.dart';
import 'package:funconnect/services/location_service/i_location_service.dart';
import 'package:logger/logger.dart';

part 'main_app_event.dart';
part 'main_app_state.dart';

class MainAppBloc extends Bloc<MainAppEvent, MainAppState> {
  MainAppBloc() : super(MainAppInitial()) {
    on<MainAppEvent>((event, emit) {
      Logger().i("Main App Event called");
    });
    on<InitializeMainApp>((event, emit) {
      Logger().i("Main App bloc inituakized");
    });

    on<PlacesLoaded>(_onPlacesLoaded);
  }

  final _locationService = locator<ILocationService>();
  final _placeRepository = locator<IPlaceRepository>();

  UserModel get user => _placeRepository.user;
  AppLocation? get location => _locationService.userLocation;

  FutureOr<void> _onPlacesLoaded(
      PlacesLoaded event, Emitter<MainAppState> emit) {
    Logger().i(
        "Main Place loaded method called with ${event.homeTrends.places.length} places");
    try {
      emit(HomeTrendsLoadedState(homeTrends: event.homeTrends));
    } catch (e) {
      Logger().e(e);
    }
  }
}
