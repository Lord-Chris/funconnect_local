import 'dart:convert';

import 'package:equatable/equatable.dart';

class PlaceModel extends Equatable {
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
  final double distance;

  const PlaceModel({
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
    required this.distance,
  });

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
      'distance': distance,
    };
  }

  factory PlaceModel.fromMap(Map<String, dynamic> map) {
    return PlaceModel(
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
      distance: map['distance']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory PlaceModel.fromJson(String source) =>
      PlaceModel.fromMap(json.decode(source));

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
      distance,
    ];
  }
}

final mockPlace = PlaceModel.fromMap(const {
  "id": "985da381-c4b5-43e5-9944-3865a5e234b3",
  "name": "Funk-Orn",
  "headline": "Unde et rerum et.",
  "cover_image_path":
      "https://via.placeholder.com/640x480.png/002244?text=fuga",
  "description": "Qui nam vero itaque sequi voluptatem.",
  "added_by": "30edad82-8a4f-3b31-93ec-b262826b770b",
  "opens_at": "05:39:00",
  "closes_at": "19:20:00",
  "phone_e164": "08055208019",
  "avg_rating": 0,
  "avg_review_count": 0,
  "distance": 1054.7793920450083
});
