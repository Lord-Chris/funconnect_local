import 'dart:convert';

import '../../../../core/models/app_location.dart';

final mockUser = {
  "id": "98194b5c-f488-4a69-972f-179c2b7bff41",
  "email": "maduekechris65@gmail.com",
  "name": null,
  "username": null,
  "dob": null,
  "gender": null,
  "phone_e164": null,
  "created_at": "2022-12-29T20:00:59.000000Z",
  "updated_at": "2023-02-01T18:52:08.000000Z",
  "bio": null,
  "twitter_handle": null,
  "facebook_handle": null,
  "instagram_handle": null,
  "linkedIn_handle": null,
  "photo_url": null,
  "deleted_at": null,
  "location": {
    "id": "9826e5b4-98bd-41bf-b3e0-77b6e94f34d6",
    "user_id": "98194b5c-f488-4a69-972f-179c2b7bff41",
    "address": "1 Stockton St Stockton St",
    "city": "San Francisco",
    "state": "CA",
    "country": "United States",
    "lat": "37.785834",
    "long": "-122.406417"
  }
};

class UserModel {
  final String id;
  final String email;
  final String? name;
  final String? username;
  final String? gender;
  final String? dob;
  final String? phoneE164;
  final String? bio;
  final String? twitterHandle;
  final String? facebookHandle;
  final String? instagramHandle;
  final String? linkedInHandle;
  final String? photoUrl;
  final AppLocation? location;
  final String? createdAt;
  final String? updatedAt;
  final String? deletedAt;

  UserModel({
    required this.id,
    required this.email,
    this.name,
    this.username,
    this.gender,
    this.dob,
    this.phoneE164,
    this.bio,
    this.twitterHandle,
    this.facebookHandle,
    this.instagramHandle,
    this.linkedInHandle,
    this.photoUrl,
    this.location,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
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
      'bio': bio,
      'twitter_handle': twitterHandle,
      'facebook_handle': facebookHandle,
      'instagram_handle': instagramHandle,
      'linked_in_handle': linkedInHandle,
      'photo_url': photoUrl,
      'location': location?.toMap(),
      'created_at': createdAt,
      'updated_at': updatedAt,
      'deleted_at': deletedAt,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      email: map['email'] ?? '',
      name: map['name'],
      username: map['username'],
      gender: map['gender'],
      dob: map['dob'],
      phoneE164: map['phone_e164'],
      bio: map['bio'],
      twitterHandle: map['twitter_handle'],
      facebookHandle: map['facebook_handle'],
      instagramHandle: map['instagram_handle'],
      linkedInHandle: map['linked_in_handle'],
      photoUrl: map['photo_url'],
      location:
          map['location'] != null ? AppLocation.fromMap(map['location']) : null,
      createdAt: map['created_at'],
      updatedAt: map['updated_at'],
      deletedAt: map['deleted_at'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));
}
