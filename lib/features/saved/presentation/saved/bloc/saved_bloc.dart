import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:funconnect/core/app/_app.dart';
import 'package:funconnect/core/models/_models.dart';
import 'package:funconnect/core/usecases/usecase.dart';
import 'package:funconnect/features/saved/domain/usecases/fetch_user_saved_places.dart';
import 'package:funconnect/features/saved/presentation/saved/bloc/saved_event.dart';
import 'package:funconnect/features/saved/presentation/saved/bloc/saved_state.dart';
import 'package:funconnect/services/_services.dart';
import 'package:logger/logger.dart';

import '../../../data/repository/i_saved_repository.dart';

class SavedBloc extends Bloc<SavedEvent, SavedState> {
  SavedBloc() : super(SavedLoadingState()) {
    on<GetAllUserSavedPlaces>(_onGetAllUserSavedPlaces);
    on<SavedPlaceTapEvent>(_onSavedPlaceTapEvent);
  }
  final _logger = Logger();
  final _navigationService = locator<INavigationService>();
  final _locationService = locator<ILocationService>();
  final _savedPlaceRepository = locator<ISavedRepository>();

  Future<void> _onGetAllUserSavedPlaces(
    GetAllUserSavedPlaces event,
    Emitter<SavedState> emit,
  ) async {
    try {
      if (event.showLoader) emit(SavedLoadingState());
      final savedPlace = await FetchUserSavedPlaces().call(NoParams());
      emit(SavedPageFilledState(savedPlacesData: savedPlace));
    } on Failure catch (e) {
      _logger.e(e);

      emit(SavedFailureState(failure: e));
    }
  }

  FutureOr<void> _onSavedPlaceTapEvent(
    SavedPlaceTapEvent event,
    Emitter<SavedState> emit,
  ) async {
    await _navigationService.toNamed(
      Routes.placeDetailRoute,
      arguments: event.place.place?.copyWith(savedPlace: true),
    );
    add(const GetAllUserSavedPlaces(showLoader: false));
  }

  UserModel get user => _savedPlaceRepository.user;
  AppLocation? get location => _locationService.userLocation;
}
