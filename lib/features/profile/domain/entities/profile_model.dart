import 'dart:convert';

import 'package:equatable/equatable.dart';

class ProfileModel extends Equatable {
  final String? profileImageUrl;
  final String fullName;
  final String userName;
  final String email;
  final String gender;
  final String dateOfBirth;
  final String mobileNumber;
  final String? bio;
  final String? address;
  final String? city;
  final String? state;
  final String? country;
  final num? lat;
  final num? long;
  final List<String>? interests;
  final String? twitterHandle;
  final String? instagramHandle;
  final String? facebookHandle;
  final String? linkedInHandle;

  ProfileModel(
      {this.profileImageUrl,
      required this.fullName,
      required this.userName,
      required this.email,
      required this.gender,
      required this.dateOfBirth,
      required this.mobileNumber,
      this.bio,
      this.address,
      this.city,
      this.state,
      this.country,
      this.lat,
      this.long,
      this.interests,
      this.twitterHandle,
      this.instagramHandle,
      this.facebookHandle,
      this.linkedInHandle});

  ProfileModel copyWith(
      {String? profileImageUrl,
      String? fullName,
      String? userName,
      String? email,
      String? gender,
      String? dateOfBirth,
      String? mobileNumber,
      String? bio,
      String? location,
      String? address,
      String? city,
      String? state,
      String? country,
      num? lat,
      num? long,
      List<String>? interests,
      String? twitterHandle,
      String? instagramHandle,
      String? facebookHandle,
      String? linkedInHandle}) {
    return ProfileModel(
        profileImageUrl: profileImageUrl ?? this.profileImageUrl,
        fullName: fullName ?? this.fullName,
        userName: userName ?? this.userName,
        email: email ?? this.email,
        gender: gender ?? this.gender,
        dateOfBirth: dateOfBirth ?? this.dateOfBirth,
        mobileNumber: mobileNumber ?? this.mobileNumber,
        bio: bio ?? this.bio,
        address: address ?? this.address,
        city: city ?? this.city,
        state: state ?? this.state,
        country: country ?? this.country,
        lat: lat ?? this.lat,
        long: long ?? this.long,
        interests: interests ?? this.interests,
        twitterHandle: twitterHandle ?? this.twitterHandle,
        instagramHandle: instagramHandle ?? this.instagramHandle,
        facebookHandle: facebookHandle ?? this.facebookHandle,
        linkedInHandle: linkedInHandle ?? this.linkedInHandle);
  }

  factory ProfileModel.empty() => ProfileModel(
      fullName: "",
      userName: "",
      email: "",
      gender: "",
      dateOfBirth: "",
      mobileNumber: "");

  factory ProfileModel.fromMap(Map<String, dynamic> map) {
    return ProfileModel(
      email: map['email'],
      fullName: map['name'],
      userName: map['username'],
      gender: map['gender'],
      dateOfBirth: map['dob'],
      mobileNumber: map['phone_e164'],
      address: map['address'],
      city: map['city'],
      state: map['state'],
      country: map['country'],
      lat: num.tryParse(map['lat']) ?? 0,
      long: num.tryParse(map['long']) ?? 0,
      bio: map['bio'],
      facebookHandle: map['facebook_handle'],
      twitterHandle: map['twitter_handle'],
      instagramHandle: map['instagram_handle'],
      linkedInHandle: map['linkedIn_handle'],
      profileImageUrl: map['profile_photo'],
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'email': email,
      'name': fullName,
      'username': userName,
      'gender':gender,
       'dob':dateOfBirth,
      'phone_e164':mobileNumber,
      'address': address,
      'city': city,
      'state': state,
      'country': country,
      'lat': lat,
      'long':long,
      'bio':bio,
      'facebook_handle':facebookHandle,
      'instagram_handle':instagramHandle,
      'twitter_handle':twitterHandle,
      'linkedIn_handle':linkedInHandle,
      'profile_photo': profileImageUrl
    };
  }

  String toJson() => json.encode(toMap());

  factory ProfileModel.fromJson(String source) =>
      ProfileModel.fromMap(json.decode(source));




  @override
  List<Object?> get props => [
        profileImageUrl,
        fullName,
        userName,
        email,
        gender,
        dateOfBirth,
        mobileNumber,
        bio,
        address,
        city,
        state,
        country,
        lat,
        long,
        interests,
        twitterHandle,
        instagramHandle,
        facebookHandle,
        linkedInHandle.hashCode
      ];

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is ProfileModel && other.hashCode == hashCode;
  }
}
