import 'dart:convert';

import 'package:funconnect/core/model/app_location.dart';

class ProfileSetupParam {
  final String name;
  final String username;
  final String gender;
  final String? address;
  final String? city;
  final String? state;
  final String? country;
  final String? lat;
  final String? long;

  ProfileSetupParam({
    required this.name,
    required this.username,
    required this.gender,
    this.address,
    this.city,
    this.state,
    this.country,
    this.lat,
    this.long,
  });

  ProfileSetupParam addLocation(AppLocation location) {
    return ProfileSetupParam(
      name: name,
      username: username,
      gender: gender,
      address: location.address,
      city: location.city,
      state: location.state,
      country: location.country,
      lat: location.lat.toString(),
      long: location.long.toString(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'username': username,
      'gender': gender.toLowerCase(),
      if (address != null) 'address': address,
      if (city != null) 'city': city,
      if (state != null) 'state': state,
      if (country != null) 'country': country,
      if (lat != null) 'lat': lat,
      if (long != null) 'long': long,
    };
  }

  String toJson() => json.encode(toMap());
}
