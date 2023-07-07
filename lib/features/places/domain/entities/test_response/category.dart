import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'datum.dart';

class Category extends Equatable {
  final String? name;
  final List<Datum>? data;

  const Category({this.name, this.data});

  factory Category.fromMap(Map<String, dynamic> data) => Category(
        name: data['name'] as String?,
        data: (data['data'] as List<dynamic>?)
            ?.map((e) => Datum.fromMap(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toMap() => {
        'name': name,
        'data': data?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Category].
  factory Category.fromJson(String data) {
    return Category.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Category] to a JSON string.
  String toJson() => json.encode(toMap());

  Category copyWith({
    String? name,
    List<Datum>? data,
  }) {
    return Category(
      name: name ?? this.name,
      data: data ?? this.data,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [name, data];
}
