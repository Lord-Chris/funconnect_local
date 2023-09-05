import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:funconnect/core/app/locator.dart';
import 'package:funconnect/core/constants/_constants.dart';
import 'package:funconnect/core/constants/hive_keys.dart';
import 'package:funconnect/services/local_storage_service/i_local_storage_service.dart';

part 'theme_switcher_event.dart';

class ThemeSwitcherBloc extends Bloc<ThemeSwitcherEvent, ThemeData> {
  ThemeSwitcherBloc() : super(ThemeData.light()) {
    on<ThemeSwitcherEvent>((event, emit) {
      if (isDark) {
        emit(ThemeData.dark());
      } else {
        emit(ThemeData.light());
      }
    });
    on<ThemeSwitcherEventToggle>((event, emit) {
      if (isDark) {
        _localStorageService.write(HiveKeys.userBoxId,
            key: StorageKeys.isDarkMode, data: false);
        emit(ThemeData.light());
      } else {
        _localStorageService.write(HiveKeys.userBoxId,
            key: StorageKeys.isDarkMode, data: true);
        emit(ThemeData.dark());
      }
    });
  }

  final _localStorageService = locator<ILocalStorageService>();

  bool get isDark => _localStorageService.read<bool>(HiveKeys.userBoxId,
      key: StorageKeys.isDarkMode, def: false);
}
