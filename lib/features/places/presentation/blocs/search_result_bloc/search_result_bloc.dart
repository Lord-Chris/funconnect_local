import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:funconnect/core/app/_app.dart';
import 'package:funconnect/core/models/_models.dart';
import 'package:funconnect/features/places/data/repository/i_place_repository.dart';
import 'package:funconnect/features/places/domain/entities/search_query_param.dart';
import 'package:funconnect/features/places/domain/usecases/search_place.dart';
import 'package:funconnect/features/places/presentation/blocs/search_result_bloc/search_result_event.dart';
import 'package:funconnect/features/places/presentation/blocs/search_result_bloc/search_result_state.dart';
import 'package:funconnect/features/places/presentation/widgets/search_filter_sheet.dart';
import 'package:funconnect/services/_services.dart';
import 'package:logger/logger.dart';

class SearchResultBloc extends Bloc<SearchResultEvent, SearchResultState> {
  SearchResultBloc() : super(SearchResultIdleState()) {
    on<SearchBarChangedEvent>(_onSearchBarChangedEvent);
    on<PlaceTapEvent>(_onPlaceTapEvent);
    on<ToggleViewSearchResult>(_onToggleViewSearchResult);
    on<FilterTapEvent>(_onFilterTapEvent);
  }
  final _navigationService = locator<INavigationService>();
  final _dialogAndSheetService = locator<IDialogAndSheetService>();
  final _logger = Logger();

  FutureOr<void> _onSearchBarChangedEvent(
    SearchBarChangedEvent event,
    Emitter<SearchResultState> emit,
  ) async {
    try {
      emit(SearchResultLoadingState());
      final res =
          await SearchPlaces().call(SearchQueryParam(param: event.query));
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

  FutureOr<void> _onToggleViewSearchResult(
    ToggleViewSearchResult event,
    Emitter<SearchResultState> emit,
  ) {
    if (this.state is! SearchResultIdleState) return null;
    final state = this.state as SearchResultIdleState;
    emit(state.copyWith(showRecents: !state.showRecents));
  }

  FutureOr<void> _onFilterTapEvent(
    FilterTapEvent event,
    Emitter<SearchResultState> emit,
  ) async {
    final params = await _dialogAndSheetService.showAppBottomSheet(
      SearchFilterSheet(
        categories: locator<IPlaceRepository>().categories?.data ?? [],
      ),
    );
    if (params == null) return;
    try {
      emit(SearchResultLoadingState());
      final res = await SearchPlaces().call(params);
      emit(SearchResultIdleState(placeData: res));
    } on Failure catch (e) {
      emit(SearchResultIdleState());
      _logger.e(e);
    }
  }
}
