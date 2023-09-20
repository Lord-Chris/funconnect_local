import 'package:funconnect/core/app/_app.dart';
import 'package:funconnect/core/constants/hive_keys.dart';
import 'package:funconnect/core/constants/storage_keys.dart';
import 'package:funconnect/services/local_storage_service/i_local_storage_service.dart';

final _localStorageService = locator<ILocalStorageService>();

Future<bool> isDarkMode() async {
  bool isDark = _localStorageService.read<bool>(HiveKeys.userBoxId,
      key: StorageKeys.isDarkMode, def: false);

  return isDark;
}

Future<void> setTheme({required bool isDark}) async {
  await _localStorageService.write(HiveKeys.userBoxId,
      key: StorageKeys.isDarkMode, data: isDark);
}
