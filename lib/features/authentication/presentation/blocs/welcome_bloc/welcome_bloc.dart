import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:funconnect/features/authentication/presentation/blocs/welcome_bloc/welcome_event.dart';
import 'package:funconnect/features/authentication/presentation/blocs/welcome_bloc/welcome_state.dart';
import 'package:funconnect/features/authentication/presentation/views/email_signin_view.dart';

class WelcomeBloc extends Bloc<WelcomeEvent, WelcomeState> {
  WelcomeBloc() : super(WelcomeInitialState()) {
    on<EmailSignInEvent>(_onEmailSignInEvent);
    on<GoogleSignInEvent>(_onGoogleSignInEvent);
    on<AppleSignInEvent>(_onAppleSignInEvent);
    on<TermsOfUseTapEvent>(_onTermsOfUseTapEvent);
    on<PrivacyPolicyTapEvent>(_onPrivacyPolicyTapEvent);
  }

  FutureOr<void> _onEmailSignInEvent(
    EmailSignInEvent event,
    Emitter<WelcomeState> emit,
  ) {
    Navigator.push(
      event.context,
      MaterialPageRoute(builder: (_) => const EmailSigninView()),
    );
  }

  FutureOr<void> _onGoogleSignInEvent(
    GoogleSignInEvent event,
    Emitter<WelcomeState> emit,
  ) {}

  FutureOr<void> _onAppleSignInEvent(
    AppleSignInEvent event,
    Emitter<WelcomeState> emit,
  ) {}

  FutureOr<void> _onTermsOfUseTapEvent(
    TermsOfUseTapEvent event,
    Emitter<WelcomeState> emit,
  ) {}

  FutureOr<void> _onPrivacyPolicyTapEvent(
    PrivacyPolicyTapEvent event,
    Emitter<WelcomeState> emit,
  ) {}
}
