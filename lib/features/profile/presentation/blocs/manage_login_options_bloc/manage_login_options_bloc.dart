import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:funconnect/core/models/_models.dart';
import 'package:funconnect/core/usecases/usecase.dart';
import 'package:funconnect/features/profile/domain/usecases/delete_user_account.dart';
import 'package:funconnect/features/profile/domain/usecases/logout_user.dart';
import 'package:funconnect/services/_services.dart';
import 'package:funconnect/shared/dialogs/_dialogs.dart';

import '../../../../../core/app/_app.dart';

part 'manage_login_options_event.dart';
part 'manage_login_options_state.dart';

class ManageLoginOptionsBloc
    extends Bloc<ManageLoginOptionsEvent, ManageLoginOptionsState> {
  UserModel profile;

  ManageLoginOptionsBloc(this.profile)
      : super(ManageLoginOptionsInitialState(
            profile: profile, isUpdatingProfile: false)) {
    on<BackTapEvent>(_onBackTapEvent);
    on<LogoutTapEvent>(_onLogoutTapEvent);
    on<DeleteTapAccountEvent>(_onDeleteAccountTapEvent);
  }

  final _navigationService = locator<INavigationService>();
  final _dialogAndSheetService = locator<IDialogAndSheetService>();

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
    _dialogAndSheetService.showAppDialog(AppAlertDialog(
      isHighPriority: false,
      title: "Logout",
      body: "Are you sure you want to logout of this device?",
      positiveLabel: "Logout",
      negativeLabel: "Cancel",
      negativeCallBack: () {
        _navigationService.back();
      },
      positiveCallBack: () async {
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
      positiveCallBack: () async {
        try {
          await DeleteUserAccount().call(NoParams());
          _navigationService.offAllNamed(Routes.welcomeViewRoute, (_) => false);
          _dialogAndSheetService.showAppDialog(const StatusDialog(
              isError: false, title: "Alert", body: "User Account Deleted"));
        } on Failure catch (e) {
          _navigationService.back();
          _dialogAndSheetService.showAppDialog(StatusDialog(
              isError: true, title: "Error Deleting Account", body: e.message));
        }
      },
    ));
  }
}
