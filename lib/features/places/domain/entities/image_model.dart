import 'dart:convert';

import 'package:equatable/equatable.dart';

class ImageModel extends Equatable {
  final String id;
  final String placeId;
  final String path;
  final DateTime updatedAt;
  const ImageModel({
    required this.id,
    required this.placeId,
    required this.path,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'place_id': placeId,
      'path': path,
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  factory ImageModel.fromMap(Map<String, dynamic> map) {
    return ImageModel(
      id: map['id'] ?? '',
      placeId: map['place_id'] ?? '',
      path: map['path'] ?? '',
      updatedAt: DateTime.parse(map['updated_at']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ImageModel.fromJson(String source) =>
      ImageModel.fromMap(json.decode(source));

  @override
  List<Object> get props => [id, placeId, path, updatedAt];
}
