import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:funconnect/features/places/domain/entities/pivot_model.dart';

class CategoryModel extends Equatable {
  final String id;
  final String name;
  final String status;
  final String coverPhoto;
  final PivotModel? pivot;

  const CategoryModel({
    required this.id,
    required this.name,
    required this.status,
    required this.coverPhoto,
    this.pivot,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'status': status,
      'cover_photo': coverPhoto,
      'pivot': pivot?.toMap(),
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      status: map['status'] ?? '',
      coverPhoto: map['cover_photo'] ?? '',
      pivot: map['pivot'] != null ? PivotModel.fromMap(map['pivot']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoryModel.fromJson(String source) =>
      CategoryModel.fromMap(json.decode(source));

  @override
  List<Object> get props {
    return [
      id,
      name,
      status,
      coverPhoto,
    ];
  }
}

final mockCategory = CategoryModel.fromMap(const {
  "id": "985da381-fa15-425b-bc30-0044424e167e",
  "name": "kbdbu",
  "status": "active",
  "cover_photo": "https://via.placeholder.com/640x480.png/00ffff?text=quisquam"
});
