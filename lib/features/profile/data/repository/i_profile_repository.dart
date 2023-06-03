import 'dart:io';

import 'package:funconnect/core/models/_models.dart';

import '../../domain/entities/login_options_model.dart';

abstract class IProfileRepository {
  Future<UserModel> fetchUserProfile();
  Future<void> updateUserProfile(UserModel profile);
  Future<void> updateUserLocation(AppLocation location);
  Future<void> updateProfileImage(File image);
  Future<LoginOptionsModel> fetchLogInOptions();
  Future<LoginOptionsModel> updateLogInOptions(LoginOptionsData data);
  Future<void> logout();
  Future<void> deleteAccount();
}
