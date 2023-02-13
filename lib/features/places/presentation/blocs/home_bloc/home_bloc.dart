import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:funconnect/core/app/_app.dart';
import 'package:funconnect/core/models/_models.dart';
import 'package:funconnect/core/usecases/usecase.dart';
import 'package:funconnect/features/places/presentation/blocs/home_bloc/home_event.dart';
import 'package:funconnect/features/places/presentation/blocs/home_bloc/home_state.dart';
import 'package:funconnect/services/_services.dart';

import '../../../domain/usecases/fetch_home_trends.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeLoadingState()) {
    on<HomeInitEvent>(_onHomeInitEvent);
    on<InterestTapEvent>(_onInterestTapEvent);
    on<PlaceTapEvent>(_onPlaceTapEvent);
    on<NotificationTapEvent>(_onNotificationTapEvent);
  }

  final _navigationService = locator<INavigationService>();

  FutureOr<void> _onHomeInitEvent(
    HomeInitEvent event,
    Emitter<HomeState> emit,
  ) async {
    final res = await FetchHomeTrends().call(NoParams());
    emit(HomeIdleState(
      interests: List.generate(10, (_) => "Fine Dining $_"),
      homeTrends: res,
    ));
  }

  FutureOr<void> _onInterestTapEvent(
    InterestTapEvent event,
    Emitter<HomeState> emit,
  ) async {
    if (state is! HomeIdleState) return;
    final data = state as HomeIdleState;

    if (data.interest == event.interest) {
      emit(HomeIdleState(
        interests: List.generate(10, (_) => "Fine Dining $_"),
        homeTrends: data.homeTrends,
      ));
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
        homeTrends: data.homeTrends,
      ));
    } on Failure catch (e) {
      emit(HomeFailureState(failure: e));
      emit(HomeIdleState(
        interest: data.interest,
        interests: data.interests,
        interestPlaces: data.interestPlaces,
        homeTrends: data.homeTrends,
      ));
    }
  }

  FutureOr<void> _onPlaceTapEvent(
    PlaceTapEvent event,
    Emitter<HomeState> emit,
  ) {
    _navigationService.toNamed(Routes.placeDetailRoute, arguments: event.place);
  }

  FutureOr<void> _onNotificationTapEvent(
    NotificationTapEvent event,
    Emitter<HomeState> emit,
  ) {
    _navigationService.toNamed(Routes.notificationsViewRoute);
  }
}
