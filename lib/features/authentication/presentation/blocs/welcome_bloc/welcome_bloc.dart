import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:funconnect/core/app/_app.dart';
import 'package:funconnect/core/models/_models.dart';
import 'package:funconnect/core/usecases/usecase.dart';
import 'package:funconnect/core/utils/general_utils.dart';
import 'package:funconnect/features/authentication/domain/usecases/apple_signin_usecase.dart';
import 'package:funconnect/features/authentication/domain/usecases/google_signin_usecase.dart';
import 'package:funconnect/features/authentication/presentation/blocs/welcome_bloc/welcome_event.dart';
import 'package:funconnect/features/authentication/presentation/blocs/welcome_bloc/welcome_state.dart';
import 'package:funconnect/services/_services.dart';
import 'package:funconnect/shared/constants/_constants.dart';
import 'package:funconnect/shared/dialogs/status_dialog.dart';
import 'package:logger/logger.dart';

import '../../../domain/usecases/email_signin_usecase.dart';

class WelcomeBloc extends Bloc<WelcomeEvent, WelcomeState> {
  WelcomeBloc() : super(WelcomeInitialState()) {
    on<EmailSignInEvent>(_onEmailSignInEvent);
    on<GoogleSignInEvent>(_onGoogleSignInEvent);
    on<AppleSignInEvent>(_onAppleSignInEvent);
    on<TandCTapEvent>(_onTandCTapEvent);
    on<PrivacyPolicyTapEvent>(_onPrivacyPolicyTapEvent);
  }

  final _navigationService = locator<INavigationService>();
  final _dialogAndSheetService = locator<IDialogAndSheetService>();
  final _logger = Logger();

  FutureOr<void> _onEmailSignInEvent(
    EmailSignInEvent event,
    Emitter<WelcomeState> emit,
  ) async {
    try {
      FocusManager.instance.primaryFocus?.unfocus();
      emit(WelcomeLoadingState());
      final res = await EmailSignInUsecase().call(event.email);
      emit(WelcomeSuccessState());
      _navigationService.toNamed(
        Routes.verifyEmailRoute,
        arguments: res,
      );
    } on Failure catch (e) {
      _logger.e(e);
      emit(WelcomeFailureState());
      _dialogAndSheetService.showAppDialog(StatusDialog(
          isError: true, title: "Error Signing In", body: e.message));
    }
  }

  FutureOr<void> _onGoogleSignInEvent(
    GoogleSignInEvent event,
    Emitter<WelcomeState> emit,
  ) async {
    try {
      FocusManager.instance.primaryFocus?.unfocus();
      emit(WelcomeLoadingState());
      await GoogleSignInUsecase().call(NoParams());
      emit(WelcomeSuccessState());
    } on Failure {
      emit(WelcomeFailureState());
    }
  }

  FutureOr<void> _onAppleSignInEvent(
    AppleSignInEvent event,
    Emitter<WelcomeState> emit,
  ) async {
    try {
      FocusManager.instance.primaryFocus?.unfocus();
      emit(WelcomeLoadingState());
      await AppleSignInUsecase().call(NoParams());
      emit(WelcomeSuccessState());
    } on Failure {
      emit(WelcomeFailureState());
    }
  }

  FutureOr<void> _onTandCTapEvent(
    TandCTapEvent event,
    Emitter<WelcomeState> emit,
  ) {
    GeneralUtils.openUrl(Uri.parse(AppConstants.tandC));
  }

  FutureOr<void> _onPrivacyPolicyTapEvent(
    PrivacyPolicyTapEvent event,
    Emitter<WelcomeState> emit,
  ) {
    GeneralUtils.openUrl(Uri.parse(AppConstants.privacyPolicy));
  }
}
