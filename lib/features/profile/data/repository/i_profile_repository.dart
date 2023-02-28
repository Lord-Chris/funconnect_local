import 'dart:io';

import 'package:funconnect/core/models/_models.dart';
import 'package:funconnect/features/profile/domain/entities/profile_model.dart';

abstract class IProfileRepository {
  Future<ProfileModel> fetchUserProfile();
  Future<void> updateUserProfile(ProfileModel profile);
  Future<void> updateUserLocation(AppLocation location);
  Future<void> updateProfileImage(File image);
  Future<void> logout();
  Future<void> deleteAccount();
}
