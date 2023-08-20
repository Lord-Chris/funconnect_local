// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class DeleteMiniPlanResponse {
  final List data;
  final String message;
  DeleteMiniPlanResponse({
    required this.data,
    required this.message,
  });

  DeleteMiniPlanResponse copyWith({
    List? data,
    String? message,
  }) {
    return DeleteMiniPlanResponse(
      data: data ?? this.data,
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'data': data,
      'message': message,
    };
  }

  factory DeleteMiniPlanResponse.fromMap(Map<String, dynamic> map) {
    return DeleteMiniPlanResponse(
      data: List.from((map['data'] as List)),
      message: map['message'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory DeleteMiniPlanResponse.fromJson(String source) =>
      DeleteMiniPlanResponse.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'DeleteMiniPlanResponse(data: $data, message: $message)';

  @override
  bool operator ==(covariant DeleteMiniPlanResponse other) {
    if (identical(this, other)) return true;

    return listEquals(other.data, data) && other.message == message;
  }

  @override
  int get hashCode => data.hashCode ^ message.hashCode;
}
