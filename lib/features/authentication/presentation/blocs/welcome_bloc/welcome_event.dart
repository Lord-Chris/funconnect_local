import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

abstract class WelcomeEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class EmailSignInEvent extends WelcomeEvent {
  final BuildContext context;
  EmailSignInEvent(this.context);
}

class GoogleSignInEvent extends WelcomeEvent {}

class AppleSignInEvent extends WelcomeEvent {}

class TermsOfUseTapEvent extends WelcomeEvent {}

class PrivacyPolicyTapEvent extends WelcomeEvent {}
