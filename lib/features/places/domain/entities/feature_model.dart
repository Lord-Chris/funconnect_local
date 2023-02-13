import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:funconnect/features/places/domain/entities/pivot_model.dart';

class FeatureModel extends Equatable {
  final String id;
  final String name;
  final PivotModel? pivot;

  const FeatureModel({
    required this.id,
    required this.name,
    this.pivot,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'pivot': pivot?.toMap(),
    };
  }

  factory FeatureModel.fromMap(Map<String, dynamic> map) {
    return FeatureModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      pivot: map['pivot'] != null ? PivotModel.fromMap(map['pivot']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory FeatureModel.fromJson(String source) =>
      FeatureModel.fromMap(json.decode(source));

  @override
  List<Object> get props => [id, name];
}
