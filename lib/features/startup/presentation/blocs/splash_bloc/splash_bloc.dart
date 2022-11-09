import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:funconnect/core/app/_app.dart';
import 'package:funconnect/features/startup/presentation/blocs/splash_bloc/splash_event.dart';
import 'package:funconnect/features/startup/presentation/blocs/splash_bloc/splash_state.dart';
import 'package:funconnect/services/_services.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitialState()) {
    on<InitializeSplashEvent>(_onSplashInit);
    on<FinishSplashEvent>(_onSplashFinished);
  }
  final _navigationService = locator<INavigationService>();

  Future<void> _onSplashInit(
    InitializeSplashEvent event,
    Emitter<SplashState> emit,
  ) async {
    await Future.delayed(const Duration(seconds: 2));
    emit(SplashFinishedState());
  }

  void _onSplashFinished(FinishSplashEvent event, Emitter<SplashState> emit) {
    // TODO: Navigate to either onboarding, auth screen or home screen here.
    bool isAuthenticated = true;
    if (isAuthenticated) {
      _navigationService.toNamed(Routes.dashboardViewRoute);
    } else {
      _navigationService.toNamed(Routes.onboardingRoute);
    }
  }
}
