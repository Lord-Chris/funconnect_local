import 'package:funconnect/core/app/_app.dart';
import 'package:funconnect/core/constants/hive_keys.dart';
import 'package:funconnect/core/constants/storage_keys.dart';
import 'package:funconnect/services/_services.dart';

mixin ApiMixin {
  final _localStorageService = locator<ILocalStorageService>();

  Future<void> saveAuthToken(String value) async {
    return await _localStorageService.write(HiveKeys.userBoxId,
        key: StorageKeys.token, data: value);
  }

  Map<String, String> get headers {
    return {
      'Content-Type': 'application/json',
      "Accept": "application/json",
      "Authorization": "Bearer $token",
      // "Access-Control-Allow-Origin": "*",
    };
  }

  String? get token => _localStorageService.read<String?>(HiveKeys.userBoxId,
      key: StorageKeys.token);
}
