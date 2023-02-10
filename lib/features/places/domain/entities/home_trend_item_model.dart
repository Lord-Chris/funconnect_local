import 'dart:convert';

import 'package:equatable/equatable.dart';

class HomeTrendItemModel<T> extends Equatable {
  final String tag;
  final String name;
  final List<T> data;

  const HomeTrendItemModel({
    required this.tag,
    required this.name,
    required this.data,
  });

  Map<String, dynamic> toMap(Map<String, dynamic> Function(T) toMap) {
    return {
      'tag': tag,
      'name': name,
      'data': data.map(toMap).toList(),
    };
  }

  factory HomeTrendItemModel.fromMap(
    Map<String, dynamic> map,
    T Function(Map<String, dynamic>) fromMap,
  ) {
    return HomeTrendItemModel<T>(
      tag: map['tag'] ?? '',
      name: map['name'] ?? '',
      data: List<T>.from(map['data']?.map((x) => fromMap(x))),
    );
  }

  String toJson(Map<String, dynamic> Function(T) toJson) =>
      json.encode(toMap(toJson));

  factory HomeTrendItemModel.fromJson(
    String source,
    T Function(Map<String, dynamic>) fromJson,
  ) =>
      HomeTrendItemModel.fromMap(json.decode(source), fromJson);

  @override
  List<Object> get props => [tag, name, data];
}
