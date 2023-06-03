import 'dart:io';

import 'package:funconnect/core/app/_app.dart';
import 'package:funconnect/core/constants/api_constants.dart';
import 'package:funconnect/core/mixins/_mixins.dart';
import 'package:funconnect/core/models/_models.dart';
import 'package:funconnect/services/_services.dart';

import '../../domain/entities/login_options_model.dart';

class RemoteProfileDataSource with ApiMixin {
  final _networkService = locator<INetworkService>();

  Future<UserModel> getUserProfile() async {
    final res = await _networkService.get(
      ApiConstants.profileSetup,
      headers: headers,
    );

    final data = res.data['data'];
    return UserModel.fromMap(data);
  }

  Future<void> updateUserProfile(UserModel profile) async {
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

  Future<LoginOptionsModel> fetchLogInOptions() async {
    final res = await _networkService.get(
      ApiConstants.settings,
      headers: headers,
    );
    return LoginOptionsModel.fromMap(res.data['data']);
  }

  Future<LoginOptionsModel> updateLogInOptions(LoginOptionsData data) async {
    final res = await _networkService.put(
      ApiConstants.settings,
      headers: headers,
      body: {'settings': data.toMap()},
    );
    return LoginOptionsModel.fromMap(res.data['data']);
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
