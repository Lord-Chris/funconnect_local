import 'dart:convert';

import 'package:equatable/equatable.dart';

class PlaceLocationModel extends Equatable {
  final String id;
  final String placeId;
  final String lat;
  final String long;
  final String address;
  final String city;
  final String state;
  final String country;

  const PlaceLocationModel({
    required this.id,
    required this.placeId,
    required this.lat,
    required this.long,
    required this.address,
    required this.city,
    required this.state,
    required this.country,
  });

  @override
  List<Object> get props => [lat, long];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'place_id': placeId,
      'lat': lat,
      'long': long,
      'address': address,
      'city': city,
      'state': state,
      'country': country,
    };
  }

  factory PlaceLocationModel.fromMap(Map<String, dynamic> map) {
    return PlaceLocationModel(
      id: map['id'] ?? '',
      placeId: map['place_id'] ?? '',
      lat: map['lat'] ?? '',
      long: map['long'] ?? '',
      address: map['address'] ?? '',
      city: map['city'] ?? '',
      state: map['state'] ?? '',
      country: map['country'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory PlaceLocationModel.fromJson(String source) =>
      PlaceLocationModel.fromMap(json.decode(source));
}

final placeLocation = PlaceLocationModel.fromMap(const {
  "id": "9871d5d7-14d0-4a13-9072-4cf8d8baf58f",
  "place_id": "9871d5d7-122c-464a-8dd2-41bbd701d127",
  "address": "41553 Haley Trafficway Suite 847\nNew Ofeliaville, CA 80611-8360",
  "city": "Lagos",
  "state": "Lagos",
  "country": "Nigeria",
  "lat": "61.502481",
  "long": "-131.854515"
});
