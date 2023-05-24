import 'dart:convert';

import 'package:funconnect/core/constants/hive_keys.dart';
import 'package:funconnect/core/models/_models.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:logger/logger.dart';

import 'i_local_storage_service.dart';

class LocalStorageService extends ILocalStorageService {
  final _log = Logger();

  @override
  Future<void> init() async {
    await Hive.initFlutter();
    await clearAll();

    // await clearAll();
    // await clearAll();
    await _openBoxes();
  }

  Future<void> _openBoxes() async {
    try {
      await Hive.openBox(HiveKeys.appBoxId);
      await Hive.openBox(HiveKeys.userBoxId);
      await Hive.openBox(HiveKeys.placesBoxId);
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
      final data = box.get(key, defaultValue: def);
      return jsonDecode(jsonEncode(data)) as T;
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
      await Hive.deleteFromDisk();
      _log.d("Cleared All Local Data");
    } on Exception catch (e) {
      _log.e(e.toString());
      throw const Failure("Something went wrong");
    }
  }
}
