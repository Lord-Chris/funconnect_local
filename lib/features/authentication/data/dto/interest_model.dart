import 'dart:convert';

import 'package:equatable/equatable.dart';

class InterestModel extends Equatable {
  final String id;
  final String name;
  final String status;
  final String coverPhoto;

  const InterestModel({
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

  factory InterestModel.fromMap(Map<String, dynamic> map) {
    return InterestModel(
      id: map['id'],
      name: map['name'],
      status: map['status'],
      coverPhoto: map['cover_photo'],
    );
  }

  String toJson() => json.encode(toMap());

  factory InterestModel.fromJson(String source) =>
      InterestModel.fromMap(json.decode(source));

  @override
  List<Object> get props => [id, name, status, coverPhoto];
}
