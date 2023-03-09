import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:funconnect/core/app/_app.dart';
import 'package:funconnect/core/models/_models.dart';
import 'package:funconnect/core/usecases/usecase.dart';
import 'package:funconnect/features/authentication/data/dto/user_model.dart';
import 'package:funconnect/features/fun_connect/saved/domain/entities/saved_place_model.dart';
import 'package:funconnect/features/fun_connect/saved/domain/usecases/fetch_user_saved_places.dart';
import 'package:funconnect/features/fun_connect/saved/presentation/blocs/saved_event.dart';
import 'package:funconnect/features/fun_connect/saved/presentation/blocs/saved_state.dart';
import 'package:funconnect/features/places/data/repository/i_place_repository.dart';
import 'package:funconnect/features/places/domain/entities/place_location_model.dart';
import 'package:funconnect/features/places/presentation/blocs/home_bloc/home_event.dart';
import 'package:funconnect/features/places/presentation/blocs/home_bloc/home_state.dart';
import 'package:funconnect/services/_services.dart';
import 'package:logger/logger.dart';

import '../../data/repository/i_saved_repository.dart';


class SavedBloc extends Bloc<SavedEvent, SavedState> {
  SavedBloc() : super(SavedLoadingState()) {
    on<SavedInitEvent>(_onSavedInitEvent);
    on<SavedPlaceTapEvent>(_onSavedPlaceTapEvent);
  }
  final _logger = Logger();
  final _navigationService = locator<INavigationService>();
  final _locationService = locator<ILocationService>();
  final _savedPlaceRepository = locator<ISavedRepository>();

  FutureOr<void> _onSavedInitEvent(
    SavedInitEvent event,
    Emitter<SavedState> emit,
  ) async {
    try {
      if (event.showLoader) emit(SavedLoadingState());
      final res = await FetchUserSavedPlaces().call(event.place);
      emit(SavedLoadingIdleState(
       savedPlaces: res as List<SavedPlaceModel>,
      ));
    } on Failure catch (e) {
      _logger.e(e);
     
    }
  }

 

  FutureOr<void> _onSavedPlaceTapEvent(
    SavedPlaceTapEvent event,
    Emitter<SavedState> emit,
  ) {
    _navigationService.toNamed(Routes.placeDetailRoute, arguments: event.place);
  }

 

  UserModel get user => _savedPlaceRepository.user;
  AppLocation? get location => _locationService.userLocation;
}
