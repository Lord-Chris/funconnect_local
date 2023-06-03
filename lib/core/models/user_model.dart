import 'dart:convert';

import 'package:equatable/equatable.dart';

import '_models.dart';

class UserModel extends Equatable {
  final String id;
  final String email;
  final String name;
  final String username;
  final String gender;
  final String dob;
  final String phoneE164;
  final String bio;
  final String photoUrl;
  final String? twitterHandle;
  final String? facebookHandle;
  final String? instagramHandle;
  final String? linkedInHandle;
  final AppLocation? location;
  final String? createdAt;
  final String? updatedAt;
  final String? deletedAt;

  const UserModel({
    required this.id,
    required this.email,
    required this.name,
    required this.username,
    required this.gender,
    required this.dob,
    required this.phoneE164,
    required this.bio,
    required this.photoUrl,
    this.twitterHandle,
    this.facebookHandle,
    this.instagramHandle,
    this.linkedInHandle,
    this.location,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory UserModel.empty() => const UserModel(
      id: "",
      name: "",
      username: "",
      email: "",
      gender: "",
      dob: "",
      phoneE164: "",
      bio: '',
      photoUrl: '');

  UserModel copyWith({
    String? id,
    String? email,
    String? name,
    String? username,
    String? gender,
    String? dob,
    String? phoneE164,
    String? bio,
    String? photoUrl,
    String? twitterHandle,
    String? facebookHandle,
    String? instagramHandle,
    String? linkedInHandle,
    AppLocation? location,
    String? createdAt,
    String? updatedAt,
    String? deletedAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      username: username ?? this.username,
      gender: gender ?? this.gender,
      dob: dob ?? this.dob,
      phoneE164: phoneE164 ?? this.phoneE164,
      bio: bio ?? this.bio,
      photoUrl: photoUrl ?? this.photoUrl,
      twitterHandle: twitterHandle ?? this.twitterHandle,
      facebookHandle: facebookHandle ?? this.facebookHandle,
      instagramHandle: instagramHandle ?? this.instagramHandle,
      linkedInHandle: linkedInHandle ?? this.linkedInHandle,
      location: location ?? this.location,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
    );
  }

  Map<String, dynamic> toBody() {
    return {
      'email': email,
      'name': name,
      'username': username,
      'gender': gender.toLowerCase(),
      'dob': dob,
      'phone_e164': phoneE164.isEmpty ? 'null' : phoneE164,
      'bio': bio,
      'facebook_handle': facebookHandle,
      'instagram_handle': instagramHandle,
      'twitter_handle': twitterHandle,
      'linkedIn_handle': linkedInHandle,
      'profile_photo': photoUrl,
    };
  }

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
      'photo_url': photoUrl,
      'twitter_handle': twitterHandle,
      'facebook_handle': facebookHandle,
      'instagram_handle': instagramHandle,
      'linked_in_handle': linkedInHandle,
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
      name: map['name'] ?? '',
      username: map['username'] ?? '',
      gender: map['gender'] ?? '',
      dob: map['dob'] ?? '',
      phoneE164: map['phone_e164'] ?? '',
      bio: map['bio'] ?? '',
      photoUrl: map['photo_url'] ?? '',
      twitterHandle: map['twitter_handle'],
      facebookHandle: map['facebook_handle'],
      instagramHandle: map['instagram_handle'],
      linkedInHandle: map['linked_in_handle'],
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

  @override
  List<Object> get props {
    return [
      id,
      email,
      name,
      username,
      gender,
      dob,
      phoneE164,
      bio,
      photoUrl,
      twitterHandle ?? '',
      facebookHandle ?? '',
      instagramHandle ?? '',
      linkedInHandle ?? '',
      location ?? '',
      createdAt ?? '',
      updatedAt ?? '',
      deletedAt ?? '',
    ];
  }
}

final mockUser = UserModel.fromMap(
  const {
    'id': '98194b5c-f488-4a69-972f-179c2b7bff41',
    'email': 'maduekechris65@gmail.com',
    'name': 'Chris Topher',
    'username': 'Chris',
    'gender': 'male',
    'dob': '2023-05-17',
    'phone_e164': '+2345678995643',
    'location': {
      'id': '9826e5b4-98bd-41bf-b3e0-77b6e94f34d6',
      'user_id': '98194b5c-f488-4a69-972f-179c2b7bff41',
      'address': '1 Stockton St Stockton St',
      'city': 'San Francisco',
      'state': 'CA',
      'country': 'United States',
      'lat': 37.785834,
      'long': -122.406417
    },
    'bio': null,
    'twitter_handle': null,
    'facebook_handle': null,
    'instagram_handle': null,
    'linkedIn_handle': null,
    'deleted_at': null,
    'api_token': '382|EgtZY47L6ZzgrJ46j6oOkGIpXJdKDqyZLtXrnBXj',
  },
);
