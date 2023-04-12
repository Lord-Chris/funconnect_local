import 'package:funconnect/core/app/_app.dart';
import 'package:funconnect/core/constants/hive_keys.dart';
import 'package:funconnect/core/constants/storage_keys.dart';
import 'package:funconnect/core/models/_models.dart';
import 'package:funconnect/services/_services.dart';

class LocalProfileDataSource {
  final _localStorageService = locator<ILocalStorageService>();

  UserModel getUserProfile() {
    final data = _localStorageService.read(
      HiveKeys.userBoxId,
      key: StorageKeys.userProfile,
      def: UserModel.empty().toJson(),
    );
    return UserModel.fromMap(data as Map<String, dynamic>);
  }

  Future<void> clearAll() async {
    await _localStorageService.clearBox(HiveKeys.userBoxId);
  }
}
