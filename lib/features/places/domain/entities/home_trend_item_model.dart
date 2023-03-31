import 'dart:convert';
import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:funconnect/features/places/domain/entities/category_model.dart';
import 'package:funconnect/features/places/domain/entities/place_model.dart';

class HomeData {
  final List<CategoryModel> interests;
  final List<HomeTrendItemModel> homeTrends;

  HomeData({
    required this.interests,
    required this.homeTrends,
  });
}

class HomeTrendItemModel<T> extends Equatable {
  final String tag;
  final String name;
  final List<T> data;

  const HomeTrendItemModel({
    required this.tag,
    required this.name,
    required this.data,
  });

  Map<String, dynamic> toMap() {
    return {
      'tag': tag,
      'name': name,
      'data': data
          .map((e) => tag == 'place'
              ? (e as PlaceModel).toMap()
              : (e as CategoryModel).toMap())
          .toList(),
    };
  }

  factory HomeTrendItemModel.fromMap(
    Map<String, dynamic> map,
  ) {
    return HomeTrendItemModel<T>(
      tag: map['tag'] ?? '',
      name: map['name'] ?? '',
      data: List<T>.from(map['data']?.map(
        (e) => map['tag'] == 'place'
            ? PlaceModel.fromMap(e)
            : CategoryModel.fromMap(e),
      )),
    );
  }

  String toJson() => json.encode(toMap());

  factory HomeTrendItemModel.fromJson(String source) =>
      HomeTrendItemModel.fromMap(json.decode(source));

  @override
  List<Object> get props => [tag, name, data, Random().nextInt(1000)];

  bool get isPlace => tag == "place";
}
