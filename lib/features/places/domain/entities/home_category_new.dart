// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:funconnect/features/places/domain/entities/category_model.dart';

class HomeCategory extends Equatable {
  final String name;
  final List<CategoryModel> data;
  const HomeCategory({
    required this.name,
    required this.data,
  });

  HomeCategory copyWith({
    String? name,
    List<CategoryModel>? data,
  }) {
    return HomeCategory(
      name: name ?? this.name,
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'data': data.map((x) => x.toMap()).toList(),
    };
  }

  factory HomeCategory.fromMap(Map<String, dynamic> map) {
    return HomeCategory(
      name: map['name'] as String,
      data: List<CategoryModel>.from(
        (map['data'] as List<dynamic>).map<CategoryModel>(
          (x) => CategoryModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory HomeCategory.fromJson(String source) =>
      HomeCategory.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [name, data];
}
