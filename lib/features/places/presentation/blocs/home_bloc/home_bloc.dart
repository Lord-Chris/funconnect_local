import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:funconnect/core/app/_app.dart';
import 'package:funconnect/core/models/_models.dart';
import 'package:funconnect/core/usecases/usecase.dart';
import 'package:funconnect/features/places/data/repository/i_place_repository.dart';
import 'package:funconnect/features/places/presentation/blocs/home_bloc/home_event.dart';
import 'package:funconnect/features/places/presentation/blocs/home_bloc/home_state.dart';
import 'package:funconnect/services/_services.dart';
import 'package:logger/logger.dart';

import '../../../../../core/utils/failure_handler.dart';
import '../../../domain/usecases/bookmark_place.dart';
import '../../../domain/usecases/fetch_home_trends.dart';
import '../../../domain/usecases/fetch_places.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeLoadingState()) {
    on<HomeInitEvent>(_onHomeInitEvent);
    on<InterestTapEvent>(_onInterestTapEvent);
    on<PlaceTapEvent>(_onPlaceTapEvent);
    on<BookmarkTapEvent>(_onBookmarkTapEvent);
    on<CategoryTapEvent>(_onCategoryTapEvent);
    on<NotificationTapEvent>(_onNotificationTapEvent);
  }
  final _logger = Logger();
  final _navigationService = locator<INavigationService>();
  final _locationService = locator<ILocationService>();
  final _placeRepository = locator<IPlaceRepository>();

  FutureOr<void> _onHomeInitEvent(
    HomeInitEvent event,
    Emitter<HomeState> emit,
  ) async {
    try {
      if (event.showLoader) emit(HomeLoadingState());
      final usecase = FetchHomeTrends();
      await usecase(NoParams());
      emit(HomeIdleState(
        interests: usecase.interests,
        homeTrends: usecase.homeTrends,
      ));
    } on Failure catch (e, s) {
      _logger.e(e);
      FailureHandler.instance.catchError(e, stackTrace: s);
      emit(const HomeIdleState(interests: []));
    }
  }

  FutureOr<void> _onInterestTapEvent(
    InterestTapEvent event,
    Emitter<HomeState> emit,
  ) async {
    if (state is! HomeIdleState) return;
    final data = state as HomeIdleState;

    if (data.interest == event.interest) {
      emit(HomeIdleState(
        interests: data.interests,
        homeTrends: data.homeTrends,
      ));
      return;
    }

    try {
      emit(HomeIdleState(interests: data.interests, interest: event.interest));
      emit(HomeSubLoadingState());
      final res = await FetchPlacesByCategory().call(event.interest.id);
      emit(HomeIdleState(
        interest: event.interest,
        interests: data.interests,
        interestPlaces: res.data,
        homeTrends: data.homeTrends,
      ));
    } on Failure catch (e, s) {
      _logger.e(e);
      emit(HomeFailureState(failure: e));
      emit(HomeIdleState(
        interest: data.interest,
        interests: data.interests,
        interestPlaces: data.interestPlaces,
        homeTrends: data.homeTrends,
      ));
      FailureHandler.instance.catchError(e, stackTrace: s);
    }
  }

  FutureOr<void> _onPlaceTapEvent(
    PlaceTapEvent event,
    Emitter<HomeState> emit,
  ) async {
    await _navigationService.toNamed(Routes.placeDetailRoute,
        arguments: event.place);
    add(const HomeInitEvent(showLoader: false));
  }

  FutureOr<void> _onCategoryTapEvent(
    CategoryTapEvent event,
    Emitter<HomeState> emit,
  ) {
    _navigationService.toNamed(Routes.categoryDetailRoute, arguments: {
      'categoryId': event.category.id,
      'categoryName': event.category.name
    });
  }

  FutureOr<void> _onNotificationTapEvent(
    NotificationTapEvent event,
    Emitter<HomeState> emit,
  ) {
    _navigationService.toNamed(Routes.notificationsViewRoute);
  }

  UserModel get user => _placeRepository.user;
  AppLocation? get location => _locationService.userLocation;

  FutureOr<void> _onBookmarkTapEvent(
    BookmarkTapEvent event,
    Emitter<HomeState> emit,
  ) async {
    if (state is! HomeIdleState) return null;
    final prevState = state as HomeIdleState;
    try {
      await BookmarkPlace().call2(event.place);
      add(const HomeInitEvent(showLoader: false));
    } on Failure catch (e, s) {
      _logger.e(e);
      FailureHandler.instance.catchError(e, stackTrace: s);
      emit(prevState);
    }
  }
}
