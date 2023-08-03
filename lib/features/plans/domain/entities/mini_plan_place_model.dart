import 'dart:convert';

import 'package:equatable/equatable.dart';

class MiniPlanPlaceModel extends Equatable {
  final String id;
  final String placeId;
  final String miniPlanId;
  final String createdAt;
  const MiniPlanPlaceModel({
    required this.id,
    required this.placeId,
    required this.miniPlanId,
    required this.createdAt,
  });

  @override
  List<Object> get props => [id, placeId, miniPlanId];

  MiniPlanPlaceModel copyWith({
    String? id,
    String? placeId,
    String? miniPlanId,
    String? createdAt,
  }) {
    return MiniPlanPlaceModel(
      id: id ?? this.id,
      placeId: placeId ?? this.placeId,
      miniPlanId: miniPlanId ?? this.miniPlanId,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'place_id': placeId});
    result.addAll({'mini_plan_id': miniPlanId});
    result.addAll({'created_at': createdAt});

    return result;
  }

  factory MiniPlanPlaceModel.fromMap(Map<String, dynamic> map) {
    return MiniPlanPlaceModel(
      id: map['id'] ?? '',
      placeId: map['place_id'] ?? '',
      miniPlanId: map['mini_plan_id'] ?? '',
      createdAt: map['created_at'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory MiniPlanPlaceModel.fromJson(String source) =>
      MiniPlanPlaceModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'MiniPlanPlaceModel(id: $id, placeId: $placeId, miniPlanId: $miniPlanId)';
}
