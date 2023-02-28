import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:funconnect/core/usecases/usecase.dart';
import 'package:funconnect/features/profile/domain/entities/profile_model.dart';
import 'package:funconnect/features/profile/domain/usecases/delete_user_account.dart';
import 'package:funconnect/features/profile/domain/usecases/logout_user.dart';
import 'package:funconnect/services/_services.dart';

import '../../../../../core/app/_app.dart';

part 'manage_login_options_event.dart';

part 'manage_login_options_state.dart';

class ManageLoginOptionsBloc
    extends Bloc<ManageLoginOptionsEvent, ManageLoginOptionsState> {
  ProfileModel profile;

  ManageLoginOptionsBloc(this.profile)
      : super(ManageLoginOptionsInitialState(
            profile: profile, isUpdatingProfile: false)) {
    on<BackTapEvent>(_onBackTapEvent);
    on<LogoutTapEvent>(_onLogoutTapEvent);
    on<DeleteTapAccountEvent>(_onDeleteAccountTapEvent);
  }

  final _navigationService = locator<INavigationService>();

  Future<FutureOr<void>> _onBackTapEvent(
    BackTapEvent event,
    Emitter<ManageLoginOptionsState> emit,
  ) async {
    _navigationService.back();
  }

  FutureOr<void> _onLogoutTapEvent(
    LogoutTapEvent event,
    Emitter<ManageLoginOptionsState> emit,
  ) async {
    await LogoutUser().call(NoParams());
    _navigationService.offAllNamed(Routes.welcomeViewRoute, (_) => false);
  }

  FutureOr<void> _onDeleteAccountTapEvent(
    DeleteTapAccountEvent event,
    Emitter<ManageLoginOptionsState> emit,
  ) async {
    await DeleteUserAccount().call(NoParams());
    _navigationService.offAllNamed(Routes.welcomeViewRoute, (_) => false);
  }
}
