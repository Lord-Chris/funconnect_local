// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:funconnect/features/places/domain/entities/home_category_new.dart';
import 'package:funconnect/features/places/domain/entities/home_place.dart';

class HomeResponseData extends Equatable {
  final List<HomeCategory> categories;
  final List<HomePlaces> places;
  const HomeResponseData({
    required this.categories,
    required this.places,
  });

  HomeResponseData copyWith({
    List<HomeCategory>? categories,
    List<HomePlaces>? places,
  }) {
    return HomeResponseData(
      categories: categories ?? this.categories,
      places: places ?? this.places,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'categories': categories.map((x) => x.toMap()).toList(),
      'places': places.map((x) => x.toMap()).toList(),
    };
  }

  factory HomeResponseData.fromMap(Map<String, dynamic> map) {
    return HomeResponseData(
      categories: (map['categories'] as List<dynamic>)
          .map((e) => HomeCategory.fromMap(e as Map<String, dynamic>))
          .toList(),
      places: (map['places'] as List<dynamic>)
          .map((e) => HomePlaces.fromMap(e as Map<String, dynamic>))
          .toList(),
    );
  }

  String toJson() => json.encode(toMap());

  factory HomeResponseData.fromJson(String source) =>
      HomeResponseData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [categories, places];
}
