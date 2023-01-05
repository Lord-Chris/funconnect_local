import 'dart:convert';

import 'package:equatable/equatable.dart';

class RequestOtpResponse extends Equatable {
  final String email;
  final String message;

  const RequestOtpResponse({
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

  factory RequestOtpResponse.fromMap(Map<String, dynamic> map) {
    return RequestOtpResponse(
      email: map['data']['email'],
      message: map['message'],
    );
  }

  String toJson() => json.encode(toMap());

  factory RequestOtpResponse.fromJson(String source) =>
      RequestOtpResponse.fromMap(json.decode(source));

  @override
  List<Object?> get props => [email, message];
}
