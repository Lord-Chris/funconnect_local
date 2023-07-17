import 'dart:math';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:funconnect/core/constants/_constants.dart';
import 'package:logger/logger.dart';
// ignore: depend_on_referenced_packages
import 'package:package_info_plus/package_info_plus.dart';

import 'i_force_update_service.dart';

class ForceUpdateAppService implements IForceUpdateAppService {
  final _logger = Logger();

  @override
  Future<String> get enforcedVersionRaw async {
    final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;
    try {
      remoteConfig.setDefaults(
        {
          RemoteConfigKeys.enforcedAppVersion: await currentVersionRaw,
        },
      );
      await remoteConfig.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(seconds: 120),
          minimumFetchInterval: const Duration(hours: 1),
        ),
      );
      await remoteConfig.fetchAndActivate();
    } catch (e) {
      _logger.e(e);
    }
    return remoteConfig.getString(RemoteConfigKeys.enforcedAppVersion);
  }

  @override
  Future<String> get currentVersionRaw async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }

  @override
  Future<bool> get needsUpdate async {
    final List<int?> currentVersion = await currentVersionRaw.then((value) {
      _logger.i('Current Version - $value');
      return value
          .split('.')
          .map((String number) => int.tryParse(number))
          .toList();
    });

    final List<int?> enforcedVersion = await enforcedVersionRaw.then((value) {
      _logger.i('Enforced Version - $value');
      return value
          .split('.')
          .map((String number) => int.tryParse(number))
          .toList();
    });
    for (int i = 0;
        i < min(enforcedVersion.length, currentVersion.length);
        i++) {
      if ((enforcedVersion[i] ?? 0) < (currentVersion[i] ?? 0)) return false;
      if ((enforcedVersion[i] ?? 0) > (currentVersion[i] ?? 0)) return true;
    }
    return false;
  }
}
