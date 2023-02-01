import 'package:equatable/equatable.dart';
import 'package:funconnect/features/authentication/data/dto/request_otp_response.dart';

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
  final RequestOtpResponse response;
  final String otp;

  VerifyEmailTapEvent({
    required this.response,
    required this.otp,
  });
}
