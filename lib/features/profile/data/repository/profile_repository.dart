import 'dart:io';

import 'package:funconnect/core/app/_app.dart';
import 'package:funconnect/core/constants/_constants.dart';
import 'package:funconnect/core/models/_models.dart';
import 'package:funconnect/features/profile/data/data_sources/remote_profile_data_source.dart';
import 'package:funconnect/services/_services.dart';

import '../data_sources/local_data_source.dart';
import 'i_profile_repository.dart';

class ProfileRepository extends IProfileRepository {
  final _connectivityService = locator<IConnectivityService>();
  final _localStorageService = locator<ILocalStorageService>();
  final _remoteDS = RemoteProfileDataSource();
  final _localDS = LocalProfileDataSource();

  @override
  Future<UserModel> fetchUserProfile() async {
    final useRemote = await _connectivityService.checkInternetConnection();
    if (!useRemote) {
      return _localDS.getUserProfile();
    }
    final userProfile = await _remoteDS.getUserProfile();
    await _localStorageService.write(
      HiveKeys.userBoxId,
      key: StorageKeys.userProfile,
      data: userProfile.toMap(),
    );
    return userProfile;
  }

  @override
  Future<void> updateUserProfile(UserModel profile) async {
    await _remoteDS.updateUserProfile(profile);
  }

  @override
  Future<void> updateUserLocation(AppLocation location) async {
    await _remoteDS.updateUserLocation(location);
  }

  @override
  Future<void> updateProfileImage(File image) async {
    await _remoteDS.updateUserProfileImage(image);
  }

  @override
  Future<void> logout() async {
    try {
      final useRemote = await _connectivityService.checkInternetConnection();
      if (useRemote) {
        await _remoteDS.logout();
      }
    } finally {
      await _localDS.clearAll();
    }
  }

  @override
  Future<void> deleteAccount() async {
    final useRemote = await _connectivityService.checkInternetConnection();
    if (useRemote) {
      await _remoteDS.deleteAccount();
      await _localDS.clearAll();
    } else {
      throw const Failure("No Internet Connection");
    }
  }
}
