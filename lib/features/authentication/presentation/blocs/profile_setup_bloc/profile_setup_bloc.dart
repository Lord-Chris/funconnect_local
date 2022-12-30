import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:funconnect/core/app/_app.dart';
import 'package:funconnect/core/model/app_location.dart';
import 'package:funconnect/core/usecases/usecase.dart';
import 'package:funconnect/features/authentication/domain/usecases/get_location_usecase.dart';
import 'package:funconnect/features/authentication/domain/usecases/profile_setup_usecase.dart';
import 'package:funconnect/features/authentication/presentation/blocs/profile_setup_bloc/profile_setup_event.dart';
import 'package:funconnect/features/authentication/presentation/blocs/profile_setup_bloc/profile_setup_state.dart';
import 'package:funconnect/models/failure.dart';
import 'package:funconnect/services/_services.dart';

class ProfileSetupBloc extends Bloc<ProfileSetupEvent, ProfileSetupState> {
  ProfileSetupBloc() : super(ProfileSetupInitialState()) {
    on<AddImageEvent>(_onAddImageEvent);
    on<ShareLocationEvent>(_onShareLocationEvent);
    on<SetupProfileEvent>(_onSetupProfileEvent);
  }

  final _navigationService = locator<INavigationService>();
  AppLocation? location;

  FutureOr<void> _onAddImageEvent(
    AddImageEvent event,
    Emitter<ProfileSetupState> emit,
  ) {}

  Future<FutureOr<void>> _onShareLocationEvent(
    ShareLocationEvent event,
    Emitter<ProfileSetupState> emit,
  ) async {
    location = await GetLocationUseCase().call(NoParams());
    print(location);
  }

  Future<FutureOr<void>> _onSetupProfileEvent(
    SetupProfileEvent event,
    Emitter<ProfileSetupState> emit,
  ) async {
    try {
      emit(ProfileSetupLoadingState());
      final param =
          location == null ? event.param : event.param.addLocation(location!);
      await ProfileSetupUseCase().call(param);
      // _navigationService.offNamed(Routes.interestViewRoute);
    } on Failure {
      emit(ProfileSetupErrorState());
    } finally {
      emit(ProfileSetupInitialState());
    }
  }
}
