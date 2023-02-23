import 'dart:convert';

import 'package:equatable/equatable.dart';

class VerifyOtpResponse extends Equatable {
  // TODO: Verify this
  final bool email;
  final String message;

  const VerifyOtpResponse({
    required this.email,
    required this.message,
  });

  Map<String, dynamic> toMap() {
    return {
      'data': {
        'email': email,
      },
      'message': message,
    };
  }

  factory VerifyOtpResponse.fromMap(Map<String, dynamic> map) {
    return VerifyOtpResponse(
      email: map['data']['email'] ?? false,
      message: map['message'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory VerifyOtpResponse.fromJson(String source) =>
      VerifyOtpResponse.fromMap(json.decode(source));

  @override
  List<Object?> get props => [email, message];
}
