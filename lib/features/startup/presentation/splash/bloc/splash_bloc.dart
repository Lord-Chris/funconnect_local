import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:funconnect/core/app/_app.dart';
import 'package:funconnect/core/constants/hive_keys.dart';
import 'package:funconnect/core/constants/storage_keys.dart';
import 'package:funconnect/features/startup/presentation/splash/bloc/splash_event.dart';
import 'package:funconnect/features/startup/presentation/splash/bloc/splash_state.dart';
import 'package:funconnect/services/_services.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitialState()) {
    on<InitializeSplashEvent>(_onSplashInit);
    on<FinishSplashEvent>(_onSplashFinished);
  }
  final _localStorageService = locator<ILocalStorageService>();
  final _forceUpdateAppService = locator<IForceUpdateAppService>();

  Future<void> _onSplashInit(
    InitializeSplashEvent event,
    Emitter<SplashState> emit,
  ) async {
    final needsUpdate = await Future.wait([
      Future.delayed(const Duration(milliseconds: 100)),
      _forceUpdateAppService.needsUpdate,
    ]);
    emit(SplashFinishedState(
      needsUpdate: needsUpdate[1],
      isAuthenticated: isAuthenticated,
      showOnboarding: showOnboarding,
    ));
  }

  Future<void> _onSplashFinished(
      FinishSplashEvent event, Emitter<SplashState> emit) async {
    // FlutterNativeSplash.remove();
    // if (await needsUpdate) {
    //   _navigationService.offNamed(Routes.versionUpdateRoute);
    //   return;
    // }
    // if (isAuthenticated) {
    //   _navigationService.offNamed(Routes.dashboardViewRoute);
    // } else {
    //   if (showOnboarding) {
    //     _navigationService.offNamed(Routes.onboardingRoute);
    //   } else {
    //     _navigationService.offNamed(Routes.welcomeViewRoute);
    //   }
    // }
  }

  Future<bool> needsUpdate() => _forceUpdateAppService.needsUpdate;

  bool get showOnboarding => _localStorageService.read(HiveKeys.appBoxId,
      key: StorageKeys.showOnboarding, def: true);

  bool get isAuthenticated => _localStorageService
      .read(HiveKeys.userBoxId, key: StorageKeys.token, def: "")
      .isNotEmpty;
}
