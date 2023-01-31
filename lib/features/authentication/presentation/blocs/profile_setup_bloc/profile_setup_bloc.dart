import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:funconnect/core/app/_app.dart';
import 'package:funconnect/core/models/_models.dart';
import 'package:funconnect/core/models/app_location.dart';
import 'package:funconnect/core/usecases/usecase.dart';
import 'package:funconnect/features/authentication/domain/usecases/get_location_usecase.dart';
import 'package:funconnect/features/authentication/domain/usecases/profile_setup_usecase.dart';
import 'package:funconnect/features/authentication/presentation/blocs/profile_setup_bloc/profile_setup_event.dart';
import 'package:funconnect/features/authentication/presentation/blocs/profile_setup_bloc/profile_setup_state.dart';
import 'package:funconnect/services/_services.dart';

import '../../../../../shared/dialogs/status_dialog.dart';

class ProfileSetupBloc extends Bloc<ProfileSetupEvent, ProfileSetupState> {
  ProfileSetupBloc() : super(ProfileSetupInitialState()) {
    on<AddImageEvent>(_onAddImageEvent);
    on<ShareLocationEvent>(_onShareLocationEvent);
    on<SetupProfileEvent>(_onSetupProfileEvent);
  }

  final _navigationService = locator<INavigationService>();
  final _dialogAndSheetService = locator<IDialogAndSheetService>();
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
      _navigationService.toNamed(Routes.interestViewRoute);
    } on Failure catch (e) {
      emit(ProfileSetupErrorState());
      _dialogAndSheetService.showAppDialog(StatusDialog(
          isError: true, title: "Error Setting up profile", body: e.message));
    } finally {
      emit(ProfileSetupInitialState());
    }
  }
}
