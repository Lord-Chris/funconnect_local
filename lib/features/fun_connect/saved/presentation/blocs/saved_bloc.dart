import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:funconnect/core/app/_app.dart';
import 'package:funconnect/core/models/_models.dart';
import 'package:funconnect/core/usecases/usecase.dart';
import 'package:funconnect/features/authentication/data/dto/user_model.dart';
import 'package:funconnect/features/fun_connect/saved/domain/usecases/fetch_user_saved_places.dart';
import 'package:funconnect/features/fun_connect/saved/presentation/blocs/saved_event.dart';
import 'package:funconnect/features/fun_connect/saved/presentation/blocs/saved_state.dart';
import 'package:funconnect/services/_services.dart';
import 'package:logger/logger.dart';

import '../../data/repository/i_saved_repository.dart';

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
      emit(SavedLoadingState());
      final savedPlace = await FetchUserSavedPlaces().call(NoParams());
      emit(UserSavedPageFilledState(savedPlacesData: savedPlace));
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
