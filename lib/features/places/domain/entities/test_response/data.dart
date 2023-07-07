import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'category.dart';
import 'place.dart';

class Data extends Equatable {
  final List<Category>? categories;
  final List<Place>? places;

  const Data({this.categories, this.places});

  factory Data.fromMap(Map<String, dynamic> data) => Data(
        categories: (data['categories'] as List<dynamic>?)
            ?.map((e) => Category.fromMap(e as Map<String, dynamic>))
            .toList(),
        places: (data['places'] as List<dynamic>?)
            ?.map((e) => Place.fromMap(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toMap() => {
        'categories': categories?.map((e) => e.toMap()).toList(),
        'places': places?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Data].
  factory Data.fromJson(String data) {
    return Data.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Data] to a JSON string.
  String toJson() => json.encode(toMap());

  Data copyWith({
    List<Category>? categories,
    List<Place>? places,
  }) {
    return Data(
      categories: categories ?? this.categories,
      places: places ?? this.places,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [categories, places];
}
