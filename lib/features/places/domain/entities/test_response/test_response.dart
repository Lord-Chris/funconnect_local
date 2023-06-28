import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'data.dart';

class TestResponse extends Equatable {
  final Data? data;
  final String? message;

  const TestResponse({this.data, this.message});

  factory TestResponse.fromMap(Map<String, dynamic> data) => TestResponse(
        data: data['data'] == null
            ? null
            : Data.fromMap(data['data'] as Map<String, dynamic>),
        message: data['message'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'data': data?.toMap(),
        'message': message,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [TestResponse].
  factory TestResponse.fromJson(String data) {
    return TestResponse.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [TestResponse] to a JSON string.
  String toJson() => json.encode(toMap());

  TestResponse copyWith({
    Data? data,
    String? message,
  }) {
    return TestResponse(
      data: data ?? this.data,
      message: message ?? this.message,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [data, message];
}
