import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:funconnect/features/startup/presentation/blocs/onboarding_bloc/onboarding_event.dart';
import 'package:funconnect/features/startup/presentation/blocs/onboarding_bloc/onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  OnboardingBloc() : super(OnboardingInitialState()) {
    on<PageChangedEvent>(_onPageChangedEvent);
    on<GetStartedEvent>(_onGetStartedEvent);
    on<LoginTapEvent>(_onLoginTapEvent);
  }
  FutureOr<void> _onPageChangedEvent(
    PageChangedEvent event,
    Emitter<OnboardingState> emit,
  ) {
    emit(OnboardingInitialState(page: event.page));
  }

  FutureOr<void> _onGetStartedEvent(
    GetStartedEvent event,
    Emitter<OnboardingState> emit,
  ) {}

  FutureOr<void> _onLoginTapEvent(
    LoginTapEvent event,
    Emitter<OnboardingState> emit,
  ) {}
}
