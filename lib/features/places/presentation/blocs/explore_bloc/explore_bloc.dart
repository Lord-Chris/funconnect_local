import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:funconnect/core/usecases/usecase.dart';
import 'package:funconnect/features/places/domain/usecases/fetch_explore.dart';
import 'package:logger/logger.dart';

import '../../../../../core/models/failure.dart';
import 'explore_event.dart';
import 'explore_state.dart';

class ExploreBloc extends Bloc<ExploreEvent, ExploreState> {
  ExploreBloc() : super(ExploreLoadingState()) {
    on<ExploreInitEvent>(_onExploreInitEvent);
  }
  final _logger = Logger();
  FutureOr<void> _onExploreInitEvent(
    ExploreInitEvent event,
    Emitter<ExploreState> emit,
  ) async {
    try {
      final exploreUsecase = FetchExploreUseCase();
      await exploreUsecase(NoParams());
      emit(ExploreIdleState(
        exploreDetails: exploreUsecase.exploreDetails?.data ?? [],
        categories: exploreUsecase.categories?.data ?? [],
        bestRatings: exploreUsecase.bestRatings?.data ?? [],
        recentlyAdded: exploreUsecase.recentlyAdded?.data ?? [],
      ));
    } on Failure catch (e) {
      _logger.e(e);
    }
  }
}
