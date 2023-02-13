import 'dart:convert';

import 'package:equatable/equatable.dart';

class PivotModel extends Equatable {
  final String placeId;
  final String? featureId;
  final String? categoryId;

  const PivotModel({
    required this.placeId,
    this.featureId,
    this.categoryId,
  });

  Map<String, dynamic> toMap() {
    return {
      'place_id': placeId,
      'feature_id': featureId,
      'category_id': categoryId,
    };
  }

  factory PivotModel.fromMap(Map<String, dynamic> map) {
    return PivotModel(
      placeId: map['place_id'] ?? '',
      featureId: map['feature_id'],
      categoryId: map['category_id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PivotModel.fromJson(String source) =>
      PivotModel.fromMap(json.decode(source));

  @override
  List<Object> get props => [placeId, featureId ?? "", categoryId ?? ""];
}
