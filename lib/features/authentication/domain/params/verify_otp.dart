import 'package:equatable/equatable.dart';

class VerifyOtpParams extends Equatable {
  final String email;
  final String requestId;
  final String otp;

  const VerifyOtpParams({
    required this.email,
    required this.requestId,
    required this.otp,
  });

  @override
  List<Object?> get props => [email, otp];

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'request_id': requestId,
      'otp': otp,
    };
  }
}
