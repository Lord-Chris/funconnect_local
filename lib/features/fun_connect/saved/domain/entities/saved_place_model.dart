import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:funconnect/features/places/domain/entities/place_model.dart';

class SavedPlaceModel<T> extends Equatable {
  final String userId;
  final String placeId;
  final String id;
  final Place? place;
  final List<T> data;
  const SavedPlaceModel({
    required this.userId,
    required this.placeId,
    required this.id,
    this.place,
    required this.data
  });

  factory SavedPlaceModel.fromMap(Map<String, dynamic> map) {
    return SavedPlaceModel<T>(
      userId: map['user_id'] ?? '',
      placeId: map['place_id'] ?? '',
      id: map['id'] ?? '',
      place: map['place'] != null ? Place.fromMap(map['place']) : null,
      data: List<T>.from(map['data']?.map(
        (e) => map['place'] == 'place'
            ? Place.fromMap(e)
            : PlaceModel.fromMap(e),
      )),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'place_id': placeId,
      'id': id,
      'place': place?.toMap(),
       'data': data
          .map((e) => place == 'place'
              ? (e as Place).toMap()
              : (e as PlaceModel).toMap())
          .toList(),
    };
  }

  String toJson() => json.encode(toMap());

  factory SavedPlaceModel.fromJson(String source) =>
      SavedPlaceModel.fromMap(json.decode(source));

  @override
  List<Object> get props {
    return [
      id,
      userId,
      placeId,
    ];
  }

  bool get isPlace => place == "place";
}

class Place extends Equatable {
  const Place({
    required this.id,
    required this.name,
    required this.headline,
    required this.coverImagePath,
    required this.description,
    required this.addedBy,
    required this.opensAt,
    required this.closesAt,
    required this.phoneE164,
    required this.avgRating,
    required this.avgReviewCount,
  });
  final String id;
  final String name;
  final String headline;
  final String coverImagePath;
  final String description;
  final String addedBy;
  final String opensAt;
  final String closesAt;
  final String phoneE164;
  final double avgRating;
  final double avgReviewCount;

  factory Place.fromMap(Map<String, dynamic> map) {
    return Place(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      headline: map['headline'] ?? '',
      coverImagePath: map['cover_image_path'] ?? '',
      description: map['description'] ?? '',
      addedBy: map['added_by'] ?? '',
      opensAt: map['opens_at'] ?? '',
      closesAt: map['closes_at'] ?? '',
      phoneE164: map['phone_e164'] ?? '',
      avgRating: map['avg_rating']?.toDouble() ?? 0,
      avgReviewCount: map['avg_review_count']?.toDouble() ?? 0,
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'headline': headline,
      'cover_image_path': coverImagePath,
      'description': description,
      'added_by': addedBy,
      'opens_at': opensAt,
      'closes_at': closesAt,
      'phone_e164': phoneE164,
      'avg_rating': avgRating,
      'avg_review_count': avgReviewCount,
    };
  }

  @override
  List<Object> get props {
    return [
      id,
      name,
      headline,
      coverImagePath,
      description,
      addedBy,
      opensAt,
      closesAt,
      phoneE164,
      avgRating,
      avgReviewCount,
    ];
  }
}
