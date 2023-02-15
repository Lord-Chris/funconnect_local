import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:funconnect/core/utils/general_utils.dart';
import 'package:funconnect/features/places/domain/entities/category_model.dart';
import 'package:funconnect/features/places/domain/entities/feature_model.dart';
import 'package:funconnect/features/places/domain/entities/image_model.dart';

import 'place_location_model.dart';

class FullPlaceModel extends Equatable {
  final String id;
  final String name;
  final String headline;
  final String coverImagePath;
  final String description;
  final String addedBy;
  final String opensAt;
  final String closesAt;
  final String phoneE164;
  final String address;
  final double avgRating;
  final double avgReviewCount;
  final double? reviewsAvgRating;
  final double reviewsCount;
  final List<CategoryModel> categories;
  final List<FeatureModel> features;
  final PlaceLocationModel? location;
  final List<ImageModel> images;
  final String similarPlaces;

  const FullPlaceModel({
    required this.id,
    required this.name,
    required this.headline,
    required this.coverImagePath,
    required this.description,
    required this.addedBy,
    required this.opensAt,
    required this.closesAt,
    required this.phoneE164,
    required this.address,
    required this.avgRating,
    required this.avgReviewCount,
    this.reviewsAvgRating,
    required this.reviewsCount,
    required this.categories,
    required this.features,
    this.location,
    required this.images,
    required this.similarPlaces,
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
      'address': address,
      'avg_rating': avgRating,
      'avg_review_count': avgReviewCount,
      'reviews_avg_rating': reviewsAvgRating,
      'reviews_count': reviewsCount,
      'categories': categories.map((x) => x.toMap()).toList(),
      'features': features.map((x) => x.toMap()).toList(),
      'location': location?.toMap(),
      'images': images.map((x) => x.toMap()).toList(),
      'similar_places': similarPlaces,
    };
  }

  factory FullPlaceModel.fromMap(Map<String, dynamic> map) {
    return FullPlaceModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      headline: map['headline'] ?? '',
      coverImagePath: map['cover_image_path'] ?? '',
      description: map['description'] ?? '',
      addedBy: map['added_by'] ?? '',
      opensAt: map['opens_at'] ?? '',
      closesAt: map['closes_at'] ?? '',
      phoneE164: map['phone_e164'] ?? '',
      address: map['address'] ?? '',
      avgRating: map['avg_rating']?.toDouble() ?? 0.0,
      avgReviewCount: map['avg_review_count']?.toDouble() ?? 0.0,
      reviewsAvgRating: double.tryParse(map['reviews_avg_rating'] ?? ""),
      reviewsCount: map['reviews_count']?.toDouble() ?? 0.0,
      categories: List<CategoryModel>.from(
          map['categories']?.map((x) => CategoryModel.fromMap(x))),
      features: List<FeatureModel>.from(
          map['features']?.map((x) => FeatureModel.fromMap(x))),
      location: map['location'] != null
          ? PlaceLocationModel.fromMap(map['location'])
          : null,
      images: List<ImageModel>.from(
          map['images']?.map((x) => ImageModel.fromMap(x))),
      similarPlaces: map['similar_places'] ?? '',
    );
  }
  String toJson() => json.encode(toMap());

  factory FullPlaceModel.fromJson(String source) =>
      FullPlaceModel.fromMap(json.decode(source));

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
      address,
      avgRating,
      avgReviewCount,
      reviewsCount,
      categories,
      features,
      images,
      similarPlaces,
    ];
  }

  TimeOfDay get opensAtParsed => GeneralUtils.stringToTimeOfDay(opensAt);
  TimeOfDay get closesAtParsed => GeneralUtils.stringToTimeOfDay(closesAt);
}

final mockFullPlace = {
  "id": "97f837d4-be25-4dd0-8b69-25270968d41d",
  "name": "Buckridge LLC",
  "headline": "Delectus quidem eaque quas non quidem.",
  "cover_image_path":
      "https://via.placeholder.com/640x480.png/009922?text=fuga",
  "description": "Tempora veritatis ullam blanditiis consectetur quos.",
  "added_by": "f7756976-1716-3930-b400-3c035ed1cd58",
  "opens_at": "09:00:00",
  "closes_at": "04:09:00",
  "phone_e164": "08009722511",
  "address": "49902 Paxton Corner\nMalcolmport, KY 43041",
  "avg_rating": 0,
  "avg_review_count": 0,
  "reviews_avg_rating": null,
  "reviews_count": 0,
  "categories": [
    {
      "id": "97f837d4-c11e-4937-ba44-a14629769754",
      "name": "lzvyo",
      "status": "inactive",
      "cover_photo": "",
      "pivot": {
        "place_id": "97f837d4-be25-4dd0-8b69-25270968d41d",
        "category_id": "97f837d4-c11e-4937-ba44-a14629769754"
      }
    },
    {
      "id": "97f837d4-c34f-4744-af0d-86db3965e7e4",
      "name": "rcteq",
      "status": "inactive",
      "cover_photo": "",
      "pivot": {
        "place_id": "97f837d4-be25-4dd0-8b69-25270968d41d",
        "category_id": "97f837d4-c34f-4744-af0d-86db3965e7e4"
      }
    },
    {
      "id": "97f837d4-c593-460f-b017-6e57d48cc789",
      "name": "euvgr",
      "status": "inactive",
      "cover_photo": "",
      "pivot": {
        "place_id": "97f837d4-be25-4dd0-8b69-25270968d41d",
        "category_id": "97f837d4-c593-460f-b017-6e57d48cc789"
      }
    }
  ],
  "features": [
    {
      "id": "97f837d4-ccef-458c-867e-ff940c1a19d5",
      "name": "zsdgr",
      "pivot": {
        "place_id": "97f837d4-be25-4dd0-8b69-25270968d41d",
        "feature_id": "97f837d4-ccef-458c-867e-ff940c1a19d5"
      }
    },
    {
      "id": "97f837d4-cff0-499e-9546-735ed13bccfa",
      "name": "eoimj",
      "pivot": {
        "place_id": "97f837d4-be25-4dd0-8b69-25270968d41d",
        "feature_id": "97f837d4-cff0-499e-9546-735ed13bccfa"
      }
    },
    {
      "id": "97f837d4-d2f7-4f80-99aa-41209a2b5c5f",
      "name": "iaami",
      "pivot": {
        "place_id": "97f837d4-be25-4dd0-8b69-25270968d41d",
        "feature_id": "97f837d4-d2f7-4f80-99aa-41209a2b5c5f"
      }
    }
  ],
  "location": null,
  "images": [
    {
      "id": "97f837d4-da0a-45d5-aacc-ad3b86a6c7c1",
      "place_id": "97f837d4-be25-4dd0-8b69-25270968d41d",
      "path": "https://via.placeholder.com/640x480.png/003366?text=ex",
      "updated_at": "2022-12-13T09:24:03.000000Z"
    },
    {
      "id": "97f837d4-dc67-46ad-8441-62d6df12511b",
      "place_id": "97f837d4-be25-4dd0-8b69-25270968d41d",
      "path": "https://via.placeholder.com/640x480.png/0000bb?text=doloribus",
      "updated_at": "2022-12-13T09:24:03.000000Z"
    },
    {
      "id": "97f837d4-dfa0-4811-823e-c1bbb237b132",
      "place_id": "97f837d4-be25-4dd0-8b69-25270968d41d",
      "path": "https://via.placeholder.com/640x480.png/00bb22?text=ad",
      "updated_at": "2022-12-13T09:24:03.000000Z"
    }
  ],
  "similarPlaces": []
};
