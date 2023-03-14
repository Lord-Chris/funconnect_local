import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:funconnect/features/places/domain/entities/place_model.dart';

class SavedPlaceModel extends Equatable {
  final String id;
  final String userId;
  final String placeId;
  final PlaceModel? place;

  const SavedPlaceModel({
    required this.id,
    required this.userId,
    required this.placeId,
    this.place,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': userId,
      'place_id': placeId,
      'place': place?.toMap(),
    };
  }

  factory SavedPlaceModel.fromMap(Map<String, dynamic> map) {
    return SavedPlaceModel(
      id: map['id'] ?? '',
      userId: map['user_id'] ?? '',
      placeId: map['place_id'] ?? '',
      place: map['place'] != null ? PlaceModel.fromMap(map['place']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory SavedPlaceModel.fromJson(String source) =>
      SavedPlaceModel.fromMap(json.decode(source));

  @override
  List<Object> get props => [
        id,
        userId,
        placeId,
        if (place != null) place!,
      ];
}
