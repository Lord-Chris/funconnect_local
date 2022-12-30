import 'dart:convert';

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

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'username': username,
      'gender': gender.toLowerCase(),
      'address': address ?? "",
      'city': city ?? "",
      'state': state ?? "",
      'country': country ?? "",
      'lat': lat ?? "",
      'long': long ?? "",
      'dob': "",
      "phone_e164": "",
    };
  }

  String toJson() => json.encode(toMap());
}
