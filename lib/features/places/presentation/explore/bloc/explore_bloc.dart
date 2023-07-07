import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:funconnect/core/app/_app.dart';
import 'package:funconnect/core/usecases/usecase.dart';
import 'package:funconnect/features/places/domain/usecases/fetch_explore.dart';
import 'package:funconnect/services/_services.dart';
import 'package:logger/logger.dart';

import '../../../../../core/models/failure.dart';
import '../../../../../core/utils/failure_handler.dart';
import 'explore_event.dart';
import 'explore_state.dart';

class ExploreBloc extends Bloc<ExploreEvent, ExploreState> {
  ExploreBloc() : super(ExploreLoadingState()) {
    on<ExploreInitEvent>(_onExploreInitEvent);
    on<PlaceTapEvent>(_onPlaceTapEvent);
    on<CategoryTapEvent>(_onCategoryTapEvent);
    on<SearchBarTapEvent>(_onSearchBarTapEvent);
  }
  final _logger = Logger();
  final _navigationService = locator<INavigationService>();

  FutureOr<void> _onExploreInitEvent(
    ExploreInitEvent event,
    Emitter<ExploreState> emit,
  ) async {
    try {
      if (event.showLoader) emit(ExploreLoadingState());
      final exploreUsecase = FetchExploreUseCase();
      await exploreUsecase(NoParams());
      emit(ExploreIdleState(
        exploreDetailsData: exploreUsecase.exploreDetails,
        categoriesData: exploreUsecase.categories,
        bestRatingsData: exploreUsecase.bestRatings,
        recentlyAddedData: exploreUsecase.recentlyAdded,
      ));
    } on Failure catch (e, s) {
      _logger.e(e);
      FailureHandler.instance.catchError(e, stackTrace: s);
      emit(ExploreFailureState(e));
    }
  }

  FutureOr<void> _onPlaceTapEvent(
    PlaceTapEvent event,
    Emitter<ExploreState> emit,
  ) {
    _navigationService.toNamed(Routes.placeDetailRoute, arguments: event.place);
  }

  FutureOr<void> _onCategoryTapEvent(
    CategoryTapEvent event,
    Emitter<ExploreState> emit,
  ) {
    _navigationService.toNamed(Routes.categoryDetailRoute,
        arguments: event.category);
  }

  FutureOr<void> _onSearchBarTapEvent(
    SearchBarTapEvent event,
    Emitter<ExploreState> emit,
  ) {
    _navigationService.toNamed(Routes.searchResultRoute);
  }
}
