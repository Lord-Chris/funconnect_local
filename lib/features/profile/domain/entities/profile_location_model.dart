import 'dart:convert';

import 'package:equatable/equatable.dart';

class ProfileLocationModel extends Equatable {
  final String? address;
  final String? city;
  final String? state;
  final String? country;
  final num? lat;
  final num? long;

  const ProfileLocationModel(
      {required this.address,
      required this.city,
      required this.state,
      required this.country,
      required this.lat,
      required this.long});

  ProfileLocationModel copyWith(
      {String? address,
      String? city,
      String? state,
      String? country,
      num? lat,
      num? long}) {
    return ProfileLocationModel(
        address: address ?? this.address,
        city: city ?? this.city,
        state: state ?? this.state,
        country: country ?? this.country,
        lat: lat ?? this.lat,
        long: long ?? this.long);
  }

  Map<String, dynamic> toBody() => toMap();

  Map<String, dynamic> toMap() {
    return {
      'address': address,
      'city': city,
      'state': state,
      'country': country,
      'lat': lat,
      'long': long,
    };
  }

  factory ProfileLocationModel.fromMap(Map<String, dynamic> map) {
    return ProfileLocationModel(
      address: map['location']['address'],
      city: map['location']['city'],
      state: map['location']['state'],
      country: map['location']['country'],
      lat: num.tryParse(map['location']['lat']) ?? 0,
      long: num.tryParse(map['location']['long']) ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProfileLocationModel.fromJson(String source) =>
      ProfileLocationModel.fromMap(json.decode(source));

  @override
  List<Object?> get props => [
        address,
        city,
        state,
        country,
        lat,
        long,
      ];

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is ProfileLocationModel && other.hashCode == hashCode;
  }
}
