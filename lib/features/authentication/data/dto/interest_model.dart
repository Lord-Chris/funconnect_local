import 'dart:convert';

import 'package:equatable/equatable.dart';

class InterestModel extends Equatable {
  final String id;
  final String name;
  final String status;

  const InterestModel({
    required this.id,
    required this.name,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'status': status,
    };
  }

  factory InterestModel.fromMap(Map<String, dynamic> map) {
    return InterestModel(
      id: map['id'],
      name: map['name'],
      status: map['status'],
    );
  }

  String toJson() => json.encode(toMap());

  factory InterestModel.fromJson(String source) =>
      InterestModel.fromMap(json.decode(source));

  @override
  List<Object> get props => [id, name, status];
}
