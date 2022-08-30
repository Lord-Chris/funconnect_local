import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:funconnect/features/startup/presentation/blocs/splash_bloc/splash_event.dart';
import 'package:funconnect/features/startup/presentation/blocs/splash_bloc/splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitialState()) {
    print("HERE dfaOOOO");
    on<InitializeSplashEvent>(_onSplashInit);
    on<FinishSplashEvent>(_onSplashFinished);
  }

  Future<void> _onSplashInit(
    InitializeSplashEvent event,
    Emitter<SplashState> emit,
  ) async {
    print("HERE OOOdsfO");
    await Future.delayed(const Duration(seconds: 2));
    emit(SplashFinishedState());
  }

  void _onSplashFinished(FinishSplashEvent event, Emitter<SplashState> emit) {
    // TODO: Navigate to either onboarding, auth screen or home screen here.
    // emit(SplashFinishedState());
    print("HERE OOOO");
  }
}
