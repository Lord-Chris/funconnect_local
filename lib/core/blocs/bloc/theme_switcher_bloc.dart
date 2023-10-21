import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:funconnect/core/app/locator.dart';
import 'package:funconnect/core/constants/_constants.dart';
import 'package:funconnect/services/local_storage_service/i_local_storage_service.dart';

import '../../themes/dark_theme.dart';
import '../../themes/light_theme.dart';

part 'theme_switcher_event.dart';

class ThemeSwitcherBloc extends Bloc<ThemeSwitcherEvent, ThemeData> {
  ThemeSwitcherBloc() : super(DarkTheme.theme) {
    on<ThemeSwitcherEvent>((event, emit) {
      if (isDark) {
        emit(DarkTheme.theme);
      } else {
        emit(LightTheme.theme);
      }
    });
    on<ThemeSwitcherEventToggle>((event, emit) {
      if (isDark) {
        _localStorageService.write(HiveKeys.userBoxId,
            key: StorageKeys.isDarkMode, data: false);
        emit(LightTheme.theme);
      } else {
        _localStorageService.write(HiveKeys.userBoxId,
            key: StorageKeys.isDarkMode, data: true);
        emit(DarkTheme.theme);
      }
    });
  }

  final _localStorageService = locator<ILocalStorageService>();

  bool get isDark => _localStorageService.read<bool>(HiveKeys.userBoxId,
      key: StorageKeys.isDarkMode, def: false);
}
