import 'dart:convert';

import 'package:equatable/equatable.dart';

class RequestOtpResponse extends Equatable {
  final String email;
  final String requestId;
  final String message;

  const RequestOtpResponse({
    required this.email,
    required this.requestId,
    required this.message,
  });

  factory RequestOtpResponse.fromMap(Map<String, dynamic> map) {
    return RequestOtpResponse(
      email: map['data']['email'],
      requestId: map['data']['request_id'],
      message: map['message'],
    );
  }

  factory RequestOtpResponse.fromJson(String source) =>
      RequestOtpResponse.fromMap(json.decode(source));

  @override
  List<Object?> get props => [email, message];
}
