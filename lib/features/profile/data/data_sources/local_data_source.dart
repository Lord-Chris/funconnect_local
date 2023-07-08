import 'package:funconnect/core/app/_app.dart';
import 'package:funconnect/core/constants/hive_keys.dart';
import 'package:funconnect/core/constants/storage_keys.dart';
import 'package:funconnect/core/models/_models.dart';
import 'package:funconnect/services/_services.dart';

import '../../domain/entities/login_options_model.dart';

class LocalProfileDataSource {
  final _localStorageService = locator<ILocalStorageService>();

  UserModel getUserProfile() {
    final data = _localStorageService.read(
      HiveKeys.userBoxId,
      key: StorageKeys.userProfile,
      def: UserModel.empty().toMap(),
    );
    return UserModel.fromMap(data);
  }

  LoginOptionsModel fetchLogInOptions() {
    final res = _localStorageService.read(
      HiveKeys.userBoxId,
      key: StorageKeys.loginOptions,
      def: const LoginOptionsModel.initial().toMap(),
    );
    return LoginOptionsModel.fromMap(res);
  }

  Future<void> clearAll() async {
    await _localStorageService.clearBox(HiveKeys.userBoxId);
    await _localStorageService.clearBox(HiveKeys.placesBoxId);
  }
}
