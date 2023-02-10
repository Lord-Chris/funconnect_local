import 'dart:convert';

import 'package:equatable/equatable.dart';

class CategoryModel extends Equatable {
  final String id;
  final String name;
  final String status;
  final String coverPhoto;

  const CategoryModel({
    required this.id,
    required this.name,
    required this.status,
    required this.coverPhoto,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'status': status,
      'cover_photo': coverPhoto,
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      status: map['status'] ?? '',
      coverPhoto: map['cover_photo'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoryModel.fromJson(String source) =>
      CategoryModel.fromMap(json.decode(source));

  @override
  List<Object> get props => [id, name, status, coverPhoto];
}

final mockCategory = CategoryModel.fromMap(const {
  "id": "985da381-fa15-425b-bc30-0044424e167e",
  "name": "kbdbu",
  "status": "active",
  "cover_photo": "https://via.placeholder.com/640x480.png/00ffff?text=quisquam"
});
