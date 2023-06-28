// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class HomeCategoryData extends Equatable {
  final String id;
  final String name;
  final String status;
  final String coverPhoto;
  const HomeCategoryData({
    required this.id,
    required this.name,
    required this.status,
    required this.coverPhoto,
  });

  HomeCategoryData copyWith({
    String? id,
    String? name,
    String? status,
    String? coverPhoto,
  }) {
    return HomeCategoryData(
      id: id ?? this.id,
      name: name ?? this.name,
      status: status ?? this.status,
      coverPhoto: coverPhoto ?? this.coverPhoto,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'status': status,
      'cover_photo': coverPhoto,
    };
  }

  factory HomeCategoryData.fromMap(Map<String, dynamic> map) {
    return HomeCategoryData(
      id: map['id'] as String,
      name: map['name'] as String,
      status: map['status'] as String,
      coverPhoto: map['cover_photo'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory HomeCategoryData.fromJson(String source) =>
      HomeCategoryData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [id, name, status, coverPhoto];
}
