import 'package:funconnect/core/app/_app.dart';
import 'package:funconnect/core/constants/hive_keys.dart';
import 'package:funconnect/core/constants/storage_keys.dart';
import 'package:funconnect/features/profile/domain/entities/profile_model.dart';
import 'package:funconnect/services/_services.dart';

class LocalProfileDataSource {
  final _localStorageService = locator<ILocalStorageService>();

  ProfileModel getUserProfile() {
    final data = _localStorageService.read(
      HiveKeys.profileBoxId,
      key: StorageKeys.userProfile,
      def: ProfileModel.empty().toJson(),
    );
    return ProfileModel.fromJson(data);
  }

  Future<void> clearAll() async {
    await _localStorageService.clearBox(
      HiveKeys.profileBoxId,
    );
    await _localStorageService.clearBox(
      HiveKeys.userBoxId,
    );
    await _localStorageService.clearBox(HiveKeys.profileBoxId);
  }
}
