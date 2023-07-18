import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:funconnect/core/models/_models.dart';
import 'package:funconnect/core/usecases/usecase.dart';
import 'package:funconnect/features/profile/domain/entities/login_options_model.dart';
import 'package:funconnect/features/profile/domain/usecases/delete_user_account.dart';
import 'package:funconnect/features/profile/domain/usecases/logout_user.dart';
import 'package:funconnect/services/_services.dart';
import 'package:funconnect/shared/dialogs/_dialogs.dart';
import 'package:logger/logger.dart';

import '../../../../../core/app/_app.dart';
import '../../../../../core/utils/failure_handler.dart';
import '../../../domain/usecases/fetch_login_options.dart';
import '../../../domain/usecases/update_login_options.dart';

part 'manage_login_options_event.dart';
part 'manage_login_options_state.dart';

class ManageLoginOptionsBloc
    extends Bloc<ManageLoginOptionsEvent, ManageLoginOptionsState> {
  UserModel profile;

  ManageLoginOptionsBloc(this.profile)
      : super(ManageLoginOptionsState(
          profile: profile,
          loginOptions: FetchLoginOptions().loginOptions.data,
        )) {
    on<ManageLoginInitEvent>(_onManageLoginInitEvent);
    on<ToggleEmailLogInEvent>(_onToggleEmailLogInEvent);
    on<ToggleAppleLogInEvent>(_onToggleAppleLogInEvent);
    on<ToggleGoogleLogInEvent>(_onToggleGoogleLogInEvent);
    on<BackTapEvent>(_onBackTapEvent);
    on<LogoutTapEvent>(_onLogoutTapEvent);
    on<DeleteTapAccountEvent>(_onDeleteAccountTapEvent);
  }

  final _navigationService = locator<INavigationService>();
  final _dialogAndSheetService = locator<IDialogAndSheetService>();
  final _fetchLoginOptionsUsecase = FetchLoginOptions();
  final _updateLoginOptionsUsecase = UpdateLoginOptions();
  final _logger = Logger();

  FutureOr<void> _onManageLoginInitEvent(
    ManageLoginInitEvent event,
    Emitter<ManageLoginOptionsState> emit,
  ) async {
    await _fetchLoginOptionsUsecase(NoParams());
    emit(
      state.copyWith(loginOptions: _fetchLoginOptionsUsecase.loginOptions.data),
    );
  }

  FutureOr<void> _onBackTapEvent(
    BackTapEvent event,
    Emitter<ManageLoginOptionsState> emit,
  ) {
    _navigationService.back();
  }

  FutureOr<void> _onLogoutTapEvent(
    LogoutTapEvent event,
    Emitter<ManageLoginOptionsState> emit,
  ) async {
    _dialogAndSheetService.showAppDialog(AppAlertDialog(
      isHighPriority: false,
      title: "Logout",
      body: "Are you sure you want to logout of this device?",
      positiveLabel: "Logout",
      negativeLabel: "Cancel",
      negativeCallBack: () {
        _navigationService.back();
      },
      positiveCallBack: (_) async {
        try {
          await LogoutUser().call(NoParams());
          _navigationService.offAllNamed(Routes.welcomeViewRoute, (_) => false);
          _dialogAndSheetService.showAppDialog(const StatusDialog(
            isError: false,
            title: "Logout",
            body: "User Logged out Successfully",
          ));
        } on Failure catch (e) {
          _navigationService.back();
          _dialogAndSheetService.showAppDialog(StatusDialog(
            isError: true,
            title: "Error Logging Out",
            body: e.message,
          ));
        }
      },
    ));
  }

  FutureOr<void> _onDeleteAccountTapEvent(
    DeleteTapAccountEvent event,
    Emitter<ManageLoginOptionsState> emit,
  ) async {
    _dialogAndSheetService.showAppDialog(AppAlertDialog(
      isHighPriority: true,
      title: "Delete Account",
      body: "Are you sure you want to delete your account?",
      positiveLabel: "Delete",
      negativeLabel: "Cancel",
      negativeCallBack: () {
        _navigationService.back();
      },
      positiveCallBack: (isBusy) async {
        try {
          isBusy?.value = !isBusy.value;
          await DeleteUserAccount().call(NoParams());
          _navigationService.offAllNamed(Routes.welcomeViewRoute, (_) => false);
          _dialogAndSheetService.showAppDialog(const StatusDialog(
            isError: false,
            title: "Alert",
            body: "User Account Deleted",
          ));
        } on Failure catch (e, s) {
          _navigationService.back();
          FailureHandler.instance.catchError(e, stackTrace: s);
          _dialogAndSheetService.showAppDialog(StatusDialog(
            isError: true,
            title: "Error Deleting Account",
            body: e.message,
          ));
        }
      },
    ));
  }

  FutureOr<void> _onToggleEmailLogInEvent(
    ToggleEmailLogInEvent event,
    Emitter<ManageLoginOptionsState> emit,
  ) async {
    final oldData = state.loginOptionsData;
    try {
      final newData = oldData.copyWith(authWithEmail: event.value);
      emit(state.copyWith(loginOptions: newData));
      await _updateLoginOptionsUsecase(newData);
    } on Failure catch (e) {
      _logger.e(e);
      emit(state.copyWith(loginOptions: oldData));
    }
  }

  FutureOr<void> _onToggleAppleLogInEvent(
    ToggleAppleLogInEvent event,
    Emitter<ManageLoginOptionsState> emit,
  ) async {
    final oldData = state.loginOptionsData;
    try {
      final newData = oldData.copyWith(authWithApple: event.value);
      emit(state.copyWith(loginOptions: newData));
      await _updateLoginOptionsUsecase(newData);
    } on Failure catch (e) {
      _logger.e(e);
      emit(state.copyWith(loginOptions: oldData));
    }
  }

  FutureOr<void> _onToggleGoogleLogInEvent(
    ToggleGoogleLogInEvent event,
    Emitter<ManageLoginOptionsState> emit,
  ) async {
    final oldData = state.loginOptionsData;
    try {
      final newData = oldData.copyWith(authWithGoogle: event.value);
      emit(state.copyWith(loginOptions: newData));
      await _updateLoginOptionsUsecase(newData);
    } on Failure catch (e) {
      _logger.e(e);
      emit(state.copyWith(loginOptions: oldData));
    }
  }
}
