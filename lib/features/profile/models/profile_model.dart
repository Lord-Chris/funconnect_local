class ProfileModel {
  final String? profileImageUrl;
  final String fullName;
  final String userName;
  final String email;
  final String gender;
  final String dateOfBirth;
  final String mobileNumber;
  final String? bio;
  final String?
      location; //TODO: change from String to Custom Location object with Longitude and Latitude due to the checkMap feature
  final List<String>?
      interests; //TODO: change from List<String> to List<InterestObject>
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
      this.location,
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
        location: location ?? this.location,
        interests: interests ?? this.interests,
        twitterHandle: twitterHandle ?? this.twitterHandle,
        instagramHandle: instagramHandle ?? this.instagramHandle,
        facebookHandle: facebookHandle ?? this.facebookHandle,
        linkedInHandle: linkedInHandle ?? this.linkedInHandle);
  }

  factory ProfileModel.empty() => ProfileModel(fullName: "", userName: "", email: "", gender: "", dateOfBirth: "", mobileNumber: "");

  @override
  int get hashCode =>
      profileImageUrl.hashCode ^
      fullName.hashCode ^
      userName.hashCode ^
      email.hashCode ^
      gender.hashCode ^
      dateOfBirth.hashCode ^
      mobileNumber.hashCode ^
      bio.hashCode ^
      location.hashCode ^
      interests.hashCode ^
      twitterHandle.hashCode ^
      instagramHandle.hashCode ^
      facebookHandle.hashCode ^
      linkedInHandle.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is ProfileModel && other.hashCode == hashCode;
  }
}
