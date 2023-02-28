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

  String toJson() => json.encode(toMap());

  factory ProfileLocationModel.fromMap(Map<String, dynamic> map) {
    return ProfileLocationModel(
      address: map['address'],
      city: map['city'],
      state: map['state'],
      country: map['country'],
      lat: num.tryParse(map['lat']) ?? 0,
      long: num.tryParse(map['long']) ?? 0,
    );
  }

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
}
