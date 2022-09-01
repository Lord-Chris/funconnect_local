import 'package:equatable/equatable.dart';

abstract class WelcomeEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class EmailSignInEvent extends WelcomeEvent {}

class GoogleSignInEvent extends WelcomeEvent {}

class AppleSignInEvent extends WelcomeEvent {}

class TermsOfUseTapEvent extends WelcomeEvent {}

class PrivacyPolicyTapEvent extends WelcomeEvent {}
