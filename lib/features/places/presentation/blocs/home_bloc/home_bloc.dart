import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:funconnect/core/models/_models.dart';
import 'package:funconnect/features/places/presentation/blocs/home_bloc/home_event.dart';
import 'package:funconnect/features/places/presentation/blocs/home_bloc/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeLoadingState()) {
    on<HomeInitEvent>(_onHomeInitEvent);
    on<InterestTapEvent>(_onInterestTapEvent);
  }

  FutureOr<void> _onHomeInitEvent(
    HomeInitEvent event,
    Emitter<HomeState> emit,
  ) async {
    await Future.delayed(const Duration(seconds: 3));
    emit(HomeIdleState(interests: List.generate(10, (_) => "Fine Dining $_")));
  }

  FutureOr<void> _onInterestTapEvent(
    InterestTapEvent event,
    Emitter<HomeState> emit,
  ) async {
    if (state is! HomeIdleState) return;
    final data = state as HomeIdleState;

    if (data.interest == event.interest) {
      emit(
          HomeIdleState(interests: List.generate(10, (_) => "Fine Dining $_")));
      return;
    }

    try {
      emit(HomeIdleState(interests: data.interests, interest: event.interest));
      emit(HomeSubLoadingState());
      await Future.delayed(const Duration(seconds: 3));
      emit(HomeIdleState(
        interest: event.interest,
        interests: data.interests,
        interestPlaces: List.generate(10, (_) => "$_ Fine Dining $_"),
      ));
    } on Failure catch (e) {
      emit(HomeFailureState(failure: e));
      emit(HomeIdleState(
        interest: data.interest,
        interests: data.interests,
        interestPlaces: data.interestPlaces,
      ));
    }
  }
}
