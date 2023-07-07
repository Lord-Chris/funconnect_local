import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'datum.dart';

class Place extends Equatable {
  final String? name;
  final List<Datum>? data;

  const Place({this.name, this.data});

  factory Place.fromMap(Map<String, dynamic> data) => Place(
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
  /// Parses the string and returns the resulting Json object as [Place].
  factory Place.fromJson(String data) {
    return Place.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Place] to a JSON string.
  String toJson() => json.encode(toMap());

  Place copyWith({
    String? name,
    List<Datum>? data,
  }) {
    return Place(
      name: name ?? this.name,
      data: data ?? this.data,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [name, data];
}
