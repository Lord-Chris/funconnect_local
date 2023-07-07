// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:funconnect/features/places/domain/entities/home_response_data.dart';

class HomeTrendsReponse extends Equatable {
  final HomeResponseData data;
  final String message;
  const HomeTrendsReponse({
    required this.data,
    required this.message,
  });

  HomeTrendsReponse copyWith({
    HomeResponseData? data,
    String? message,
  }) {
    return HomeTrendsReponse(
      data: data ?? this.data,
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'data': data.toMap(),
      'message': message,
    };
  }

  factory HomeTrendsReponse.fromMap(Map<String, dynamic> map) {
    return HomeTrendsReponse(
      data: HomeResponseData.fromMap(map['data'] as Map<String, dynamic>),
      message: map['message'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory HomeTrendsReponse.fromJson(String source) =>
      HomeTrendsReponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [data, message];
}
