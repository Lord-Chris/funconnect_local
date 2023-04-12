import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:funconnect/core/app/_app.dart';
import 'package:funconnect/core/models/_models.dart';
import 'package:funconnect/core/usecases/usecase.dart';
import 'package:funconnect/features/authentication/domain/params/profile_setup.dart';
import 'package:funconnect/features/authentication/domain/usecases/get_location_usecase.dart';
import 'package:funconnect/features/authentication/domain/usecases/profile_setup_usecase.dart';
import 'package:funconnect/features/authentication/presentation/blocs/profile_setup_bloc/profile_setup_event.dart';
import 'package:funconnect/features/authentication/presentation/blocs/profile_setup_bloc/profile_setup_state.dart';
import 'package:funconnect/services/_services.dart';
import 'package:logger/logger.dart';

import '../../../../../core/utils/failure_handler.dart';
import '../../../../../shared/dialogs/status_dialog.dart';
import '../../../domain/usecases/pick_image_usecase.dart';

class ProfileSetupBloc extends Bloc<ProfileSetupEvent, ProfileSetupState> {
  ProfileSetupBloc() : super(ProfileSetupIdleState()) {
    on<AddImageEvent>(_onAddImageEvent);
    on<ShareLocationEvent>(_onShareLocationEvent);
    on<SetupProfileEvent>(_onSetupProfileEvent);
  }

  final _navigationService = locator<INavigationService>();
  final _dialogAndSheetService = locator<IDialogAndSheetService>();
  final _logger = Logger();

  AppLocation? location;

  FutureOr<void> _onAddImageEvent(
    AddImageEvent event,
    Emitter<ProfileSetupState> emit,
  ) async {
    try {
      if (state is! ProfileSetupIdleState) return;
      final image = await PickImageUseCase().call(NoParams());
      emit(ProfileSetupIdleState(
          image: image ?? (state as ProfileSetupIdleState).image));
    } on Failure catch (e, s) {
      _logger.e(e);
      FailureHandler.instance.catchError(e, stackTrace: s);
    }
  }

  FutureOr<void> _onShareLocationEvent(
    ShareLocationEvent event,
    Emitter<ProfileSetupState> emit,
  ) async {
    try {
      location = await GetLocationUseCase().call(NoParams());
    } on Failure catch (e, s) {
      _logger.e(e);
      FailureHandler.instance.catchError(e, stackTrace: s);
    }
  }

  FutureOr<void> _onSetupProfileEvent(
    SetupProfileEvent event,
    Emitter<ProfileSetupState> emit,
  ) async {
    if (state is! ProfileSetupIdleState) return;
    final prevIdleState = state;
    try {
      emit(ProfileSetupLoadingState());
      ProfileSetupParam param =
          location == null ? event.param : event.param.addLocation(location!);

      param = param.copyWith(
        profilePhoto: (prevIdleState as ProfileSetupIdleState).image,
      );
      await ProfileSetupUseCase().call(param);
      _navigationService.toNamed(Routes.interestViewRoute);
    } on Failure catch (e, s) {
      _logger.e(e);
      FailureHandler.instance.catchError(e, stackTrace: s);
      emit(ProfileSetupErrorState());
      _dialogAndSheetService.showAppDialog(StatusDialog(
          isError: true, title: "Error Setting up profile", body: e.message));
    } finally {
      emit(prevIdleState);
    }
  }
}
