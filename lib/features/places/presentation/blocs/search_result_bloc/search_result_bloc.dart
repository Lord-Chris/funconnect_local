import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:funconnect/core/app/_app.dart';
import 'package:funconnect/core/models/_models.dart';
import 'package:funconnect/features/places/domain/usecases/search_place.dart';
import 'package:funconnect/features/places/presentation/blocs/search_result_bloc/search_result_event.dart';
import 'package:funconnect/features/places/presentation/blocs/search_result_bloc/search_result_state.dart';
import 'package:funconnect/services/_services.dart';
import 'package:logger/logger.dart';

class SearchResultBloc extends Bloc<SearchResultEvent, SearchResultState> {
  SearchResultBloc() : super(SearchResultIdleState()) {
    on<SearchBarChangedEvent>(_onSearchBarChangedEvent);
    on<PlaceTapEvent>(_onPlaceTapEvent);
  }
  final _navigationService = locator<INavigationService>();
  final _logger = Logger();

  FutureOr<void> _onSearchBarChangedEvent(
    SearchBarChangedEvent event,
    Emitter<SearchResultState> emit,
  ) async {
    try {
      emit(SearchResultLoadingState());
      final res = await SearchPlaces().call(event.query.trim());
      emit(SearchResultIdleState(placeData: res));
    } on Failure catch (e) {
      emit(SearchResultIdleState());
      _logger.e(e);
    }
  }

  FutureOr<void> _onPlaceTapEvent(
    PlaceTapEvent event,
    Emitter<SearchResultState> emit,
  ) {
    _navigationService.toNamed(Routes.placeDetailRoute, arguments: event.place);
  }
}
