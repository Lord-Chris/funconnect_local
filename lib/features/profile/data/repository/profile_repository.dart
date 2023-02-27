import 'dart:io';

import 'package:funconnect/core/app/_app.dart';
import 'package:funconnect/core/constants/_constants.dart';
import 'package:funconnect/features/profile/data/data_sources/remote_profile_data_source.dart';
import 'package:funconnect/features/places/domain/entities/full_place_model.dart';
import 'package:funconnect/features/places/domain/entities/home_trend_item_model.dart';
import 'package:funconnect/features/places/domain/entities/review_model.dart';
import 'package:funconnect/features/profile/domain/entities/profile_location_model.dart';
import 'package:funconnect/features/profile/domain/entities/profile_model.dart';
import 'package:funconnect/services/_services.dart';

import '../data_sources/local_data_source.dart';
import 'i_profile_repository.dart';

class ProfileRepository extends IProfileRepository {
  final _connectivityService = locator<IConnectivityService>();
  final _localStorageService = locator<ILocalStorageService>();
  final _remoteDS = RemotePlaceDataSource();
  final _localDS = LocalPlaceDataSource();

  @override
  Future<ProfileModel> fetchUserProfile() async {
    final useRemote = await _connectivityService.checkInternetConnection();
    if (!useRemote) {
      return _localDS.getUserProfile();
    }
    final userProfile = await _remoteDS.getUserProfile();
    await _localStorageService.write(
      HiveKeys.profileBoxId,
      key: StorageKeys.userProfile,
      data: userProfile.toJson(),
    );
    return userProfile;
  }

  @override
  Future<void> updateUserProfile(ProfileModel profile) async{
    await _remoteDS.updateUserProfile(profile);
  }

  @override
  Future<void> updateUserLocation(ProfileLocationModel location) async{
    await _remoteDS.updateUserLocation(location);
  }

  @override
  Future<void> updateProfileImage(File image) async{
    await _remoteDS.updateUserProfileImage(image);
  }
}
