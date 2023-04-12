import 'dart:io';

import 'package:funconnect/core/models/_models.dart';

abstract class IProfileRepository {
  Future<UserModel> fetchUserProfile();
  Future<void> updateUserProfile(UserModel profile);
  Future<void> updateUserLocation(AppLocation location);
  Future<void> updateProfileImage(File image);
  Future<void> logout();
  Future<void> deleteAccount();
}
