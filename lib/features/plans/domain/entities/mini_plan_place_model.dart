import 'dart:convert';

import 'package:equatable/equatable.dart';

class MiniPlanPlaceModel extends Equatable {
  final String id;
  final String placeId;
  final String miniPlanId;
  final String createdAt;
  final String dateTime;
  const MiniPlanPlaceModel({
    required this.id,
    required this.placeId,
    required this.miniPlanId,
    required this.createdAt,
    required this.dateTime,
  });

  @override
  List<Object> get props => [id, placeId, miniPlanId, createdAt, dateTime];

  MiniPlanPlaceModel copyWith({
    String? id,
    String? placeId,
    String? miniPlanId,
    String? createdAt,
    String? dateTime,
  }) {
    return MiniPlanPlaceModel(
      id: id ?? this.id,
      placeId: placeId ?? this.placeId,
      miniPlanId: miniPlanId ?? this.miniPlanId,
      createdAt: createdAt ?? this.createdAt,
      dateTime: dateTime ?? this.dateTime,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'place_id': placeId});
    result.addAll({'mini_plan_id': miniPlanId});
    result.addAll({'created_at': createdAt});
    result.addAll({'date_time': dateTime});

    return result;
  }

  factory MiniPlanPlaceModel.fromMap(Map<String, dynamic> map) {
    return MiniPlanPlaceModel(
      id: map['id'] ?? '',
      placeId: map['place_id'] ?? '',
      miniPlanId: map['mini_plan_id'] ?? '',
      createdAt: map['created_at'] ?? '',
      dateTime: map['date_time'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory MiniPlanPlaceModel.fromJson(String source) =>
      MiniPlanPlaceModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'MiniPlanPlaceModel(id: $id, placeId: $placeId, miniPlanId: $miniPlanId)';
}
