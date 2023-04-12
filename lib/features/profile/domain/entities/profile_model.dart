// import 'dart:convert';

// import 'package:equatable/equatable.dart';
// import 'package:funconnect/core/models/_models.dart';

// class ProfileModel extends Equatable {
//   final String id;
//   final String? profileImageUrl;
//   final String fullName;
//   final String userName;
//   final String email;
//   final String gender;
//   final String dateOfBirth;
//   final String mobileNumber;
//   final String? bio;
//   final AppLocation? appLocation;
//   final List<String>? interests;
//   final String? twitterHandle;
//   final String? instagramHandle;
//   final String? facebookHandle;
//   final String? linkedInHandle;

//   const ProfileModel(
//       {this.profileImageUrl,
//       required this.id,
//       required this.fullName,
//       required this.userName,
//       required this.email,
//       required this.gender,
//       required this.dateOfBirth,
//       required this.mobileNumber,
//       this.bio,
//       this.appLocation,
//       this.interests,
//       this.twitterHandle,
//       this.instagramHandle,
//       this.facebookHandle,
//       this.linkedInHandle});

//   ProfileModel copyWith(
//       {String? profileImageUrl,
//       String? id,
//       String? fullName,
//       String? userName,
//       String? email,
//       String? gender,
//       String? dateOfBirth,
//       String? mobileNumber,
//       String? bio,
//       AppLocation? appLocation,
//       List<String>? interests,
//       String? twitterHandle,
//       String? instagramHandle,
//       String? facebookHandle,
//       String? linkedInHandle}) {
//     return ProfileModel(
//         profileImageUrl: profileImageUrl ?? this.profileImageUrl,
//         fullName: fullName ?? this.fullName,
//         id: id ?? this.id,
//         userName: userName ?? this.userName,
//         email: email ?? this.email,
//         gender: gender ?? this.gender,
//         dateOfBirth: dateOfBirth ?? this.dateOfBirth,
//         mobileNumber: mobileNumber ?? this.mobileNumber,
//         bio: bio ?? this.bio,
//         appLocation: appLocation ?? this.appLocation,
//         interests: interests ?? this.interests,
//         twitterHandle: twitterHandle ?? this.twitterHandle,
//         instagramHandle: instagramHandle ?? this.instagramHandle,
//         facebookHandle: facebookHandle ?? this.facebookHandle,
//         linkedInHandle: linkedInHandle ?? this.linkedInHandle);
//   }

//   factory ProfileModel.empty() => const ProfileModel(
//       id: "",
//       fullName: "",
//       userName: "",
//       email: "",
//       gender: "",
//       dateOfBirth: "",
//       mobileNumber: "");

//   Map<String, dynamic> toMap() {
//     return {
//       'email': email,
//       'name': fullName,
//       'username': userName,
//       'gender': gender,
//       'dob': dateOfBirth,
//       'phone_e164': mobileNumber,
//       'bio': bio,
//       'location': appLocation == null ? null : appLocation!.toMap(),
//       'facebook_handle': facebookHandle,
//       'instagram_handle': instagramHandle,
//       'twitter_handle': twitterHandle,
//       'linkedIn_handle': linkedInHandle,
//       'photo_url': profileImageUrl
//     };
//   }

  // Map<String, dynamic> toBody() {
  //   return {
  //     'email': email,
  //     'name': fullName,
  //     'username': userName,
  //     'gender': gender.toLowerCase(),
  //     'dob': dateOfBirth,
  //     'phone_e164': mobileNumber.isEmpty ? 'null' : mobileNumber,
  //     'bio': bio,
  //     'facebook_handle': facebookHandle,
  //     'instagram_handle': instagramHandle,
  //     'twitter_handle': twitterHandle,
  //     'linkedIn_handle': linkedInHandle,
  //     'profile_photo': profileImageUrl
  //   };
  // }

//   factory ProfileModel.fromMap(Map<String, dynamic> map) {
//     return ProfileModel(
//       id: map['id'] ?? '',
//       email: map['email'] ?? '',
//       fullName: map['name'] ?? '',
//       userName: map['username'] ?? '',
//       gender: map['gender'] ?? 'male',
//       dateOfBirth: map['dob'] ?? '',
//       mobileNumber: (map['phone_e164'] ?? '').toString(),
//       appLocation:
//           map['location'] == null ? null : AppLocation.fromMap(map['location']),
//       bio: map['bio'] ?? '',
//       facebookHandle: map['facebook_handle'],
//       twitterHandle: map['twitter_handle'],
//       instagramHandle: map['instagram_handle'],
//       linkedInHandle: map['linkedIn_handle'],
//       profileImageUrl: map['photo_url'],
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory ProfileModel.fromJson(String source) =>
//       ProfileModel.fromMap(json.decode(source));

//   @override
//   List<Object?> get props => [
//         profileImageUrl,
//         fullName,
//         userName,
//         email,
//         gender,
//         dateOfBirth,
//         mobileNumber,
//         appLocation,
//         bio,
//         interests,
//         twitterHandle,
//         instagramHandle,
//         facebookHandle,
//         linkedInHandle
//       ];
// }
