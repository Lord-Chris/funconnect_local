import 'dart:io';

import 'package:funconnect/core/app/_app.dart';
import 'package:funconnect/core/constants/api_constants.dart';
import 'package:funconnect/core/mixins/_mixins.dart';
import 'package:funconnect/core/models/_models.dart';
import 'package:funconnect/features/profile/domain/entities/profile_model.dart';
import 'package:funconnect/services/_services.dart';

class RemoteProfileDataSource with ApiMixin {
  final _networkService = locator<INetworkService>();

  Future<ProfileModel> getUserProfile() async {
    final res = await _networkService.get(
      ApiConstants.profileSetup,
      headers: headers,
    );

    final data = res.data['data'];
    return ProfileModel.fromMap(data);
  }

  Future<void> updateUserProfile(ProfileModel profile) async {
    await _networkService.put(
      ApiConstants.profileSetup,
      headers: headers,
      body: profile.toBody(),
    );
  }

  Future<void> updateUserLocation(AppLocation location) async {
    await _networkService.put(
      ApiConstants.profileLocationSetup,
      headers: headers,
      body: location.toBody(),
    );
  }

  Future<void> updateUserProfileImage(File imageFile) async {
    await _networkService.postFile(
      ApiConstants.profileImageSetup,
      ApiConstants.imageKey,
      imageFile,
      headers: headers,
    );
  }

  Future<void> deleteAccount() async {
    await _networkService.delete(
      ApiConstants.deleteAccount,
      headers: headers,
    );
  }

  Future<void> logout() async {
    await _networkService.post(
      ApiConstants.logout,
      headers: headers,
    );
  }
}
