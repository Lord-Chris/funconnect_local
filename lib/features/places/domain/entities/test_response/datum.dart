import 'dart:convert';

import 'package:equatable/equatable.dart';

class Datum extends Equatable {
  final String? id;
  final String? name;
  final String? status;
  final String? coverPhoto;

  const Datum({this.id, this.name, this.status, this.coverPhoto});

  factory Datum.fromMap(Map<String, dynamic> data) => Datum(
        id: data['id'] as String?,
        name: data['name'] as String?,
        status: data['status'] as String?,
        coverPhoto: data['cover_photo'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'status': status,
        'cover_photo': coverPhoto,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Datum].
  factory Datum.fromJson(String data) {
    return Datum.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Datum] to a JSON string.
  String toJson() => json.encode(toMap());

  Datum copyWith({
    String? id,
    String? name,
    String? status,
    String? coverPhoto,
  }) {
    return Datum(
      id: id ?? this.id,
      name: name ?? this.name,
      status: status ?? this.status,
      coverPhoto: coverPhoto ?? this.coverPhoto,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [id, name, status, coverPhoto];
}
