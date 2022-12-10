import 'dart:convert';

import 'package:equatable/equatable.dart';

class CheckEmailResponse extends Equatable {
  final bool exists;
  final String message;

  const CheckEmailResponse({
    required this.exists,
    required this.message,
  });

  Map<String, dynamic> toMap() {
    return {
      'data': {
        'exists': exists,
      },
      'message': message,
    };
  }

  factory CheckEmailResponse.fromMap(Map<String, dynamic> map) {
    return CheckEmailResponse(
      exists: map['data']['exists'] ?? false,
      message: map['message'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CheckEmailResponse.fromJson(String source) =>
      CheckEmailResponse.fromMap(json.decode(source));

  @override
  List<Object?> get props => [exists, message];
}
