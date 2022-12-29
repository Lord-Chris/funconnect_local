import 'package:funconnect/core/constants/hive_keys.dart';
import 'package:funconnect/models/failure.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:logger/logger.dart';

import 'i_local_storage_service.dart';

class LocalStorageService extends ILocalStorageService {
  final _log = Logger();

  @override
  Future<void> init() async {
    await Hive.initFlutter();
    await _openBoxes();
  }

  // void _registerAdpaters() {
  //   if (!Hive.isAdapterRegistered(HiveKeys.userAdapterId)) {
  //     Hive.registerAdapter(UserAdapter());
  //     Hive.registerAdapter(UserLevelAdapter());
  //   }
  //   if (!Hive.isAdapterRegistered(HiveKeys.notificationAdapterId)) {
  //     Hive.registerAdapter(NotificationModelAdapter());
  //     Hive.registerAdapter(NotificationDataAdapter());
  //     Hive.registerAdapter(NotificationTypeAdapter());
  //   }
  // }

  Future<void> _openBoxes() async {
    try {
      await Hive.openBox(HiveKeys.appBoxId);
      await Hive.openBox(HiveKeys.userBoxId);
    } on Exception catch (e) {
      throw Failure(e.toString());
    }
  }

  @override
  Future<void> write(String boxId, {required String key, required data}) async {
    try {
      assert(key.isNotEmpty);
      final box = await Hive.openBox(boxId);
      await box.put(key, data);
    } on Exception catch (e) {
      _log.e(e);
    }
  }

  @override
  T read<T>(String boxId, {required String key, T? def}) {
    try {
      assert(key.isNotEmpty, "Box key must not be empty");
      final box = Hive.box(boxId);
      return box.get(key, defaultValue: def) as T;
    } on Exception catch (e) {
      _log.e(e.toString());
      throw const Failure("Something went wrong");
    }
  }

  @override
  Future<void> clearBox(String boxId) async {
    try {
      final box = await Hive.openBox(boxId);
      await box.clear();
    } on Exception catch (e) {
      _log.e(e.toString());
      throw const Failure("Something went wrong");
    }
  }

  @override
  Future<void> clearAll() async {
    try {
      return await Hive.deleteFromDisk();
    } on Exception catch (e) {
      _log.e(e.toString());
      throw const Failure("Something went wrong");
    }
  }
}
