import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:funconnect/features/places/domain/entities/full_place_model.dart';

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
  final bool savedPlace;
  final String emailAddress;
  final int showRatings;
  final String websiteUrl;

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
    required this.savedPlace,
    required this.emailAddress,
    required this.showRatings,
    required this.websiteUrl,
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
      'saved_place': savedPlace,
      'email_address': emailAddress,
      'show_ratings': showRatings,
      'website_url': websiteUrl,
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
      avgRating: map['avg_rating']?.toDouble() ?? 0.0,
      avgReviewCount: map['avg_review_count']?.toDouble() ?? 0.0,
      distance: map['distance']?.toDouble() ?? 0.0,
      savedPlace: map['saved_place'] ?? false,
      emailAddress: map['email_address'] ?? "",
      showRatings: map['show_ratings'] ?? 0,
      websiteUrl: map['website_url'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory PlaceModel.fromJson(String source) =>
      PlaceModel.fromMap(json.decode(source));

  factory PlaceModel.fromFullPlaceModel(FullPlaceModel placeModel) {
    return PlaceModel(
      id: placeModel.id,
      name: placeModel.name,
      headline: placeModel.headline,
      coverImagePath: placeModel.coverImagePath,
      description: placeModel.description,
      addedBy: placeModel.addedBy,
      opensAt: placeModel.opensAt,
      closesAt: placeModel.closesAt,
      phoneE164: placeModel.phoneE164,
      avgRating: placeModel.avgRating,
      avgReviewCount: placeModel.avgReviewCount,
      distance: 0,
      savedPlace: placeModel.savedPlace,
      emailAddress: placeModel.emailAddress,
      showRatings: placeModel.showRatings,
      websiteUrl: placeModel.websiteUrl,
    );
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
      distance,
      savedPlace,
      emailAddress,
      showRatings,
      websiteUrl,
    ];
  }

  bool get isBookmarked => savedPlace;

  PlaceModel copyWith({
    String? id,
    String? name,
    String? headline,
    String? coverImagePath,
    String? description,
    String? addedBy,
    String? opensAt,
    String? closesAt,
    String? phoneE164,
    double? avgRating,
    double? avgReviewCount,
    double? distance,
    bool? savedPlace,
    String? emailAddress,
    int? showRatings,
    String? websiteUrl,
  }) {
    return PlaceModel(
      id: id ?? this.id,
      name: name ?? this.name,
      headline: headline ?? this.headline,
      coverImagePath: coverImagePath ?? this.coverImagePath,
      description: description ?? this.description,
      addedBy: addedBy ?? this.addedBy,
      opensAt: opensAt ?? this.opensAt,
      closesAt: closesAt ?? this.closesAt,
      phoneE164: phoneE164 ?? this.phoneE164,
      avgRating: avgRating ?? this.avgRating,
      avgReviewCount: avgReviewCount ?? this.avgReviewCount,
      distance: distance ?? this.distance,
      savedPlace: savedPlace ?? this.savedPlace,
      emailAddress: emailAddress ?? this.emailAddress,
      showRatings: showRatings ?? this.showRatings,
      websiteUrl: websiteUrl ?? this.websiteUrl,
    );
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
  "distance": 1054.7793920450083,
  "website_url": null,
});
