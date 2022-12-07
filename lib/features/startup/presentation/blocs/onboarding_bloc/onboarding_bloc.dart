import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:funconnect/core/app/_app.dart';
import 'package:funconnect/features/startup/presentation/blocs/onboarding_bloc/onboarding_event.dart';
import 'package:funconnect/features/startup/presentation/blocs/onboarding_bloc/onboarding_state.dart';
import 'package:funconnect/services/_services.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  OnboardingBloc() : super(OnboardingInitialState()) {
    on<PageChangedEvent>(_onPageChangedEvent);
    on<GetStartedEvent>(_onGetStartedEvent);
    on<LoginTapEvent>(_onLoginTapEvent);
  }

  final _navigationService = locator<INavigationService>();

  FutureOr<void> _onPageChangedEvent(
    PageChangedEvent event,
    Emitter<OnboardingState> emit,
  ) {
    emit(OnboardingInitialState(page: event.page));
  }

  FutureOr<void> _onGetStartedEvent(
    GetStartedEvent event,
    Emitter<OnboardingState> emit,
  ) {
    _navigationService.toNamed(Routes.emailSignInRoute);
  }

  FutureOr<void> _onLoginTapEvent(
    LoginTapEvent event,
    Emitter<OnboardingState> emit,
  ) {}
}
