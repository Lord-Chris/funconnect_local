import 'dart:io';

import 'package:funconnect/features/profile/domain/entities/profile_location_model.dart';
import 'package:funconnect/features/profile/domain/entities/profile_model.dart';

abstract class IProfileRepository {
  Future<ProfileModel> fetchUserProfile();
  Future<void> updateUserProfile(ProfileModel profile);
  Future<void> updateUserLocation(ProfileLocationModel location);
  Future<void> updateProfileImage(File image);
  Future<void> logout();
  Future<void> deleteAccount();
}
