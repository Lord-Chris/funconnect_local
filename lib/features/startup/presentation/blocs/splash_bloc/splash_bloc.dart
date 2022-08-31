import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:funconnect/features/startup/presentation/blocs/splash_bloc/splash_event.dart';
import 'package:funconnect/features/startup/presentation/blocs/splash_bloc/splash_state.dart';
import 'package:funconnect/features/startup/presentation/views/onboarding_view.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitialState()) {
    on<InitializeSplashEvent>(_onSplashInit);
    on<FinishSplashEvent>(_onSplashFinished);
  }

  Future<void> _onSplashInit(
    InitializeSplashEvent event,
    Emitter<SplashState> emit,
  ) async {
    await Future.delayed(const Duration(seconds: 2));
    emit(SplashFinishedState());
  }

  void _onSplashFinished(FinishSplashEvent event, Emitter<SplashState> emit) {
    // TODO: Navigate to either onboarding, auth screen or home screen here.
    Navigator.push(
      event.context,
      MaterialPageRoute(builder: (context) => const OnboardingView()),
    );
  }
}
