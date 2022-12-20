import 'package:equatable/equatable.dart';

abstract class VerifyEmailEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ResendCodeEvent extends VerifyEmailEvent {}

class ChangeTimerEvent extends VerifyEmailEvent {
  final int time;
  ChangeTimerEvent({
    required this.time,
  });
}

class PinFieldChangedEvent extends VerifyEmailEvent {}

class VerifyEmailTapEvent extends VerifyEmailEvent {
  final String email;
  final String otp;

  VerifyEmailTapEvent({
    required this.email,
    required this.otp,
  });
}
