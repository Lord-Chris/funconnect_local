import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:funconnect/core/app/_app.dart';
import 'package:funconnect/core/usecases/usecase.dart';
import 'package:funconnect/features/authentication/domain/usecases/apple_signin_usecase.dart';
import 'package:funconnect/features/authentication/domain/usecases/email_signin_usecase.dart';
import 'package:funconnect/features/authentication/domain/usecases/google_signin_usecase.dart';
import 'package:funconnect/features/authentication/presentation/blocs/welcome_bloc/welcome_event.dart';
import 'package:funconnect/features/authentication/presentation/blocs/welcome_bloc/welcome_state.dart';
import 'package:funconnect/models/failure.dart';
import 'package:funconnect/services/_services.dart';

class WelcomeBloc extends Bloc<WelcomeEvent, WelcomeState> {
  WelcomeBloc() : super(WelcomeInitialState()) {
    on<EmailSignInEvent>(_onEmailSignInEvent);
    on<GoogleSignInEvent>(_onGoogleSignInEvent);
    on<AppleSignInEvent>(_onAppleSignInEvent);
    on<TermsOfUseTapEvent>(_onTermsOfUseTapEvent);
    on<PrivacyPolicyTapEvent>(_onPrivacyPolicyTapEvent);
  }

  final _navigationService = locator<INavigationService>();

  FutureOr<void> _onEmailSignInEvent(
    EmailSignInEvent event,
    Emitter<WelcomeState> emit,
  ) {
    try {
      FocusManager.instance.primaryFocus?.unfocus();
      emit(WelcomeInitialState());
      // await Future.delayed(const Duration(seconds: 2));
      EmailSignInUsecase().call(event.email);
      emit(WelcomeSuccessState());
      _navigationService.toNamed(Routes.verifyEmailRoute);
    } on Failure {
      emit(WelcomeFailureState());
    }
  }

  FutureOr<void> _onGoogleSignInEvent(
    GoogleSignInEvent event,
    Emitter<WelcomeState> emit,
  ) {
    try {
      FocusManager.instance.primaryFocus?.unfocus();
      emit(WelcomeInitialState());
      GoogleSignInUsecase().call(NoParams());
      emit(WelcomeSuccessState());
    } on Failure {
      emit(WelcomeFailureState());
    }
  }

  FutureOr<void> _onAppleSignInEvent(
    AppleSignInEvent event,
    Emitter<WelcomeState> emit,
  ) {
    try {
      FocusManager.instance.primaryFocus?.unfocus();
      emit(WelcomeInitialState());
      AppleSignInUsecase().call(NoParams());
      emit(WelcomeSuccessState());
    } on Failure {
      emit(WelcomeFailureState());
    }
  }

  FutureOr<void> _onTermsOfUseTapEvent(
    TermsOfUseTapEvent event,
    Emitter<WelcomeState> emit,
  ) {}

  FutureOr<void> _onPrivacyPolicyTapEvent(
    PrivacyPolicyTapEvent event,
    Emitter<WelcomeState> emit,
  ) {}
}
