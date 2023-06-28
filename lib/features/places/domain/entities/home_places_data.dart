// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class HomePlacesData extends Equatable {
  final String id;
  final String name;
  final String headline;
  final String coverImagePath;
  final String description;
  final String addedBy;
  final String opensAt;
  final String closesAt;
  final String phoneE164;
  final int avgRating;
  final int avgReviewCount;
  final String emailAddress;
  final String websiteUrl;
  final int showRatings;
  final double distance;
  final bool savedPlace;
  const HomePlacesData({
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
    required this.emailAddress,
    required this.websiteUrl,
    required this.showRatings,
    required this.distance,
    required this.savedPlace,
  });

  HomePlacesData copyWith({
    String? id,
    String? name,
    String? headline,
    String? coverImagePath,
    String? description,
    String? addedBy,
    String? opensAt,
    String? closesAt,
    String? phoneE164,
    int? avgRating,
    int? avgReviewCount,
    String? emailAddress,
    String? websiteUrl,
    int? showRatings,
    double? distance,
    bool? savedPlace,
  }) {
    return HomePlacesData(
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
      emailAddress: emailAddress ?? this.emailAddress,
      websiteUrl: websiteUrl ?? this.websiteUrl,
      showRatings: showRatings ?? this.showRatings,
      distance: distance ?? this.distance,
      savedPlace: savedPlace ?? this.savedPlace,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'headline': headline,
      'cover_image_path': coverImagePath,
      'description': description,
      'added_by': addedBy,
      'opens_at': opensAt,
      'closes_at': closesAt,
      'phoneE164': phoneE164,
      'avg_rating': avgRating,
      'avg_review_count': avgReviewCount,
      'email_address': emailAddress,
      'website_url': websiteUrl,
      'show_ratings': showRatings,
      'distance': distance,
      'saved_place': savedPlace,
    };
  }

  factory HomePlacesData.fromMap(Map<String, dynamic> map) {
    return HomePlacesData(
      id: map['id'] ?? "",
      name: map['name'] ?? "",
      headline: map['headline'] ?? "",
      coverImagePath: map['cover_image_path'] ?? "",
      description: map['description'] ?? "",
      addedBy: map['added_by'] ?? "",
      opensAt: map['opens_at'] ?? "",
      closesAt: map['closes_at'] ?? "",
      phoneE164: map['phoneE164'] ?? "",
      avgRating: map['avg_rating'] as int,
      avgReviewCount: map['avg_review_count'] as int,
      emailAddress: map['email_address'] ?? "",
      websiteUrl: map['website_url'] ?? "",
      showRatings: map['show_ratings'] as int,
      distance: map['distance'] as double,
      savedPlace: map['saved_place'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory HomePlacesData.fromJson(String source) =>
      HomePlacesData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

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
      emailAddress,
      websiteUrl,
      showRatings,
      distance,
      savedPlace,
    ];
  }
}
