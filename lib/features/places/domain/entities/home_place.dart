// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'place_model.dart';

class HomePlaces extends Equatable {
  final String name;
  final List<PlaceModel> data;
  const HomePlaces({
    required this.name,
    required this.data,
  });

  HomePlaces copyWith({
    String? name,
    List<PlaceModel>? data,
  }) {
    return HomePlaces(
      name: name ?? this.name,
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'data': data.map((x) => x.toMap()).toList(),
    };
  }

  factory HomePlaces.fromMap(Map<String, dynamic> map) {
    return HomePlaces(
      name: map['name'] as String,
      data: List<PlaceModel>.from(
        (map['data'] as List<dynamic>).map<PlaceModel>(
          (x) => PlaceModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory HomePlaces.fromJson(String source) =>
      HomePlaces.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [name, data];
}
