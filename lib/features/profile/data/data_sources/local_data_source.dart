import 'package:funconnect/core/app/_app.dart';
import 'package:funconnect/core/constants/hive_keys.dart';
import 'package:funconnect/core/constants/storage_keys.dart';
import 'package:funconnect/features/places/domain/entities/home_trend_item_model.dart';
import 'package:funconnect/features/profile/domain/entities/profile_model.dart';
import 'package:funconnect/services/_services.dart';

class LocalPlaceDataSource {
  final _localStorageService = locator<ILocalStorageService>();

  ProfileModel getUserProfile() {
    final data = _localStorageService.read(
      HiveKeys.profileBoxId,
      key: StorageKeys.userProfile,
      def: ProfileModel.empty().toJson(),
    );
    return ProfileModel.fromJson(data);
  }
}
