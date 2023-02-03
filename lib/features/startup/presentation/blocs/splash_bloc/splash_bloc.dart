import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:funconnect/core/app/_app.dart';
import 'package:funconnect/core/constants/hive_keys.dart';
import 'package:funconnect/core/constants/storage_keys.dart';
import 'package:funconnect/features/startup/presentation/blocs/splash_bloc/splash_event.dart';
import 'package:funconnect/features/startup/presentation/blocs/splash_bloc/splash_state.dart';
import 'package:funconnect/services/_services.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitialState()) {
    on<InitializeSplashEvent>(_onSplashInit);
    on<FinishSplashEvent>(_onSplashFinished);
  }
  final _navigationService = locator<INavigationService>();
  final _localStorageService = locator<ILocalStorageService>();

  Future<void> _onSplashInit(
    InitializeSplashEvent event,
    Emitter<SplashState> emit,
  ) async {
    await Future.delayed(const Duration(seconds: 2));
    emit(SplashFinishedState());
  }

  void _onSplashFinished(FinishSplashEvent event, Emitter<SplashState> emit) {
    if (!isAuthenticated) {
      _navigationService.toNamed(Routes.dashboardViewRoute);
    } else {
      if (!isFirstTime) {
        _navigationService.toNamed(Routes.onboardingRoute);
      } else {
        _navigationService.toNamed(Routes.welcomeViewRoute);
      }
    }
  }

  bool get isFirstTime => _localStorageService.read(HiveKeys.appBoxId,
      key: StorageKeys.isFirstTime, def: true);

  bool get isAuthenticated =>
      _localStorageService.read(HiveKeys.userBoxId, key: StorageKeys.token) !=
      null;
}
