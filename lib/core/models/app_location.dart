import 'dart:convert';

import 'package:equatable/equatable.dart';

class AppLocation extends Equatable {
  final String? id;
  final String? userId;
  final double lat;
  final double long;
  final String? address;
  final String? city;
  final String? state;
  final String? country;

  const AppLocation({
    this.id,
    this.userId,
    required this.lat,
    required this.long,
    this.address,
    this.city,
    this.state,
    this.country,
  });

  @override
  List<Object> get props => [lat, long];

  @override
  String toString() {
    return 'AppLocation(lat: $lat, long: $long, address: $address, city: $city, state: $state, country: $country)';
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': userId,
      'lat': lat,
      'long': long,
      'address': address,
      'city': city,
      'state': state,
      'country': country,
    };
  }

  Map<String, dynamic> toBody() {
    return {
      'lat': lat,
      'long': long,
      'address': address,
      'city': city,
      'state': state,
      'country': country,
    };
  }

  factory AppLocation.fromMap(Map<String, dynamic> map) {
    return AppLocation(
      id: map['id'],
      userId: map['user_id'],
      lat: double.parse(map["lat"].toString()),
      long: double.parse(map["long"].toString()),
      address: map['address'],
      city: map['city'],
      state: map['state'],
      country: map['country'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AppLocation.fromJson(String source) =>
      AppLocation.fromMap(json.decode(source));

  String get parsedAddress => '$city $state';
}
