import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:funconnect/features/profile/domain/entities/profile_location_model.dart';

class ProfileModel extends Equatable {
  final String id;
  final String? profileImageUrl;
  final String fullName;
  final String userName;
  final String email;
  final String gender;
  final String dateOfBirth;
  final String mobileNumber;
  final String? bio;
  final ProfileLocationModel? locationModel;
  final List<String>? interests;
  final String? twitterHandle;
  final String? instagramHandle;
  final String? facebookHandle;
  final String? linkedInHandle;

  const ProfileModel(
      {this.profileImageUrl,
      required this.id,
      required this.fullName,
      required this.userName,
      required this.email,
      required this.gender,
      required this.dateOfBirth,
      required this.mobileNumber,
      this.bio,
      this.locationModel,
      this.interests,
      this.twitterHandle,
      this.instagramHandle,
      this.facebookHandle,
      this.linkedInHandle});

  ProfileModel copyWith(
      {String? profileImageUrl,
      String? id,
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
        id: id ?? this.id,
        userName: userName ?? this.userName,
        email: email ?? this.email,
        gender: gender ?? this.gender,
        dateOfBirth: dateOfBirth ?? this.dateOfBirth,
        mobileNumber: mobileNumber ?? this.mobileNumber,
        bio: bio ?? this.bio,
        interests: interests ?? this.interests,
        twitterHandle: twitterHandle ?? this.twitterHandle,
        instagramHandle: instagramHandle ?? this.instagramHandle,
        facebookHandle: facebookHandle ?? this.facebookHandle,
        linkedInHandle: linkedInHandle ?? this.linkedInHandle);
  }

  factory ProfileModel.empty() => const ProfileModel(
      id:"",
      fullName: "",
      userName: "",
      email: "",
      gender: "",
      dateOfBirth: "",
      mobileNumber: "");

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'name': fullName,
      'username': userName,
      'gender': gender,
      'dob': dateOfBirth,
      'phone_e164': mobileNumber,
      'bio': bio,
      'location': locationModel!.toMap(),
      'facebook_handle': facebookHandle,
      'instagram_handle': instagramHandle,
      'twitter_handle': twitterHandle,
      'linkedIn_handle': linkedInHandle,
      'profile_photo': profileImageUrl
    };
  }
    Map<String, dynamic> toBody(){
    return {
      'email': email,
      'name': fullName,
      'username': userName,
      'gender':gender.toLowerCase(),
       'dob':dateOfBirth,
      'phone_e164':mobileNumber.isEmpty?'null':mobileNumber,
      'bio':bio,
      // 'address':  locationModel!.address??'',
      // 'city': locationModel!.city??'',
      // 'state': locationModel!.state??'',
      // 'country': locationModel!.country??'',
      // 'lat': locationModel!.lat??0,
      // 'long':locationModel!.long??0,
      'facebook_handle':facebookHandle,
      'instagram_handle':instagramHandle,
      'twitter_handle':twitterHandle,
      'linkedIn_handle':linkedInHandle,
      'profile_photo': profileImageUrl
    };
  }

  factory ProfileModel.fromMap(Map<String, dynamic> map) {

    return ProfileModel(
      id: map['id'],
      email: map['email'],
      fullName: map['name'].toString(),
      userName: map['username'].toString(),
      gender: map['gender']??'Male',
      dateOfBirth: map['dob']??DateTime.now().toString(),
      mobileNumber: map['phone_e164'].toString(),
      locationModel: ProfileLocationModel.fromMap(map['location']),
      bio: map['bio'],
      facebookHandle: map['facebook_handle'],
      twitterHandle: map['twitter_handle'],
      instagramHandle: map['instagram_handle'],
      linkedInHandle: map['linkedIn_handle'],
      profileImageUrl: map['photo_url'],
    );
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
        interests,
        twitterHandle,
        instagramHandle,
        facebookHandle,
        linkedInHandle
      ];

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is ProfileModel && other.hashCode == hashCode;
  }
}
