import 'dart:convert';

import 'package:equatable/equatable.dart';

class MiniPlanPlaceModel extends Equatable {
  final String id;
  final String placeId;
  final String miniPlanId;
  const MiniPlanPlaceModel({
    required this.id,
    required this.placeId,
    required this.miniPlanId,
  });

  @override
  List<Object> get props => [id, placeId, miniPlanId];

  MiniPlanPlaceModel copyWith({
    String? id,
    String? placeId,
    String? miniPlanId,
  }) {
    return MiniPlanPlaceModel(
      id: id ?? this.id,
      placeId: placeId ?? this.placeId,
      miniPlanId: miniPlanId ?? this.miniPlanId,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'placeId': placeId});
    result.addAll({'miniPlanId': miniPlanId});

    return result;
  }

  factory MiniPlanPlaceModel.fromMap(Map<String, dynamic> map) {
    return MiniPlanPlaceModel(
      id: map['id'] ?? '',
      placeId: map['placeId'] ?? '',
      miniPlanId: map['miniPlanId'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory MiniPlanPlaceModel.fromJson(String source) =>
      MiniPlanPlaceModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'MiniPlanPlaceModel(id: $id, placeId: $placeId, miniPlanId: $miniPlanId)';
}
