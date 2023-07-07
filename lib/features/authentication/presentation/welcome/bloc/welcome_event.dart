import 'package:equatable/equatable.dart';

abstract class WelcomeEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class EmailSignInEvent extends WelcomeEvent {
  final String email;

  EmailSignInEvent({
    required this.email,
  });
}

class GoogleSignInEvent extends WelcomeEvent {}

class AppleSignInEvent extends WelcomeEvent {}

class TandCTapEvent extends WelcomeEvent {}

class PrivacyPolicyTapEvent extends WelcomeEvent {}
