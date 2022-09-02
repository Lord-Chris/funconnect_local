import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:funconnect/core/app/_app.dart';
import 'package:funconnect/features/authentication/presentation/blocs/welcome_bloc/welcome_event.dart';
import 'package:funconnect/features/authentication/presentation/blocs/welcome_bloc/welcome_state.dart';
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
    _navigationService.toNamed(Routes.emailSignInRoute);
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
