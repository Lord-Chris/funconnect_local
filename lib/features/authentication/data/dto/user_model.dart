import 'dart:convert';

class UserModel {
  final String id;
  final String email;
  final String? name;
  final String? username;
  final String? gender;
  final String? dob;
  final String? phoneE164;
  final List location;

  UserModel({
    required this.id,
    required this.email,
    this.name,
    this.username,
    this.gender,
    this.dob,
    this.phoneE164,
    required this.location,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'username': username,
      'gender': gender,
      'dob': dob,
      'phone_e164': phoneE164,
      'location': location,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      email: map['email'],
      name: map['name'],
      username: map['username'],
      gender: map['gender'],
      dob: map['dob'],
      phoneE164: map['phone_e164'],
      location: List.from(map['location']),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));
}
