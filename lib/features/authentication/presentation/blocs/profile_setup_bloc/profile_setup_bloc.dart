import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:funconnect/core/app/_app.dart';
import 'package:funconnect/features/authentication/data/repositories/i_authentication_repository.dart';
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

  final _authenticationRepository = locator<IAuthenticationRepository>();
  final _navigationService = locator<INavigationService>();

  FutureOr<void> _onAddImageEvent(
    AddImageEvent event,
    Emitter<ProfileSetupState> emit,
  ) {}

  FutureOr<void> _onShareLocationEvent(
    ShareLocationEvent event,
    Emitter<ProfileSetupState> emit,
  ) {}

  Future<FutureOr<void>> _onSetupProfileEvent(
    SetupProfileEvent event,
    Emitter<ProfileSetupState> emit,
  ) async {
    try {
      emit(ProfileSetupLoadingState());
      await _authenticationRepository.setUpProfile(event.param);
      _navigationService.toNamed(Routes.interestViewRoute);
    } on Failure {
      emit(ProfileSetupErrorState());
    } finally {
      emit(ProfileSetupSuccessState());
    }
  }
}
