import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:funconnect/core/app/_app.dart';
import 'package:funconnect/core/models/failure.dart';
import 'package:funconnect/features/places/presentation/category_detail/bloc/category_detail_event.dart';
import 'package:funconnect/features/places/presentation/category_detail/bloc/category_detail_state.dart';
import 'package:funconnect/services/_services.dart';
import 'package:logger/logger.dart';

import '../../../../../core/utils/failure_handler.dart';
import '../../../domain/usecases/fetch_places.dart';

class CategoryDetailBloc
    extends Bloc<CategoryDetailEvent, CategoryDetailState> {
  CategoryDetailBloc() : super(CategoryDetailLoadingState()) {
    on<CategoryInitEvent>(_onCategoryInitEvent);
    on<PlaceTapEvent>(_onPlaceTapEvent);
    on<SearchBarTapEvent>(_onSearchEvent);
    on<LoadMorePlaceEvent>(_onLoadMore);
  }
  final _navigationService = locator<INavigationService>();
  final _logger = Logger();

  FutureOr<void> _onCategoryInitEvent(
    CategoryInitEvent event,
    Emitter<CategoryDetailState> emit,
  ) async {
    try {
      emit(CategoryDetailLoadingState());
      final res = await FetchPlacesByCategory().call(event.categoryId);
      emit(CategoryDetailIdleState(placeData: res));
    } on Failure catch (e, s) {
      _logger.e(e);
      FailureHandler.instance.catchError(e, stackTrace: s);
      emit(CategoryDetailFailureState(e));
    }
  }

  FutureOr<void> _onPlaceTapEvent(
    PlaceTapEvent event,
    Emitter<CategoryDetailState> emit,
  ) {
    _navigationService.toNamed(Routes.placeDetailRoute, arguments: event.place);
  }

  FutureOr<void> _onSearchEvent(
    SearchBarTapEvent event,
    Emitter<CategoryDetailState> emit,
  ) {
    _navigationService.toNamed(Routes.searchResultRoute);
  }

  FutureOr<void> _onLoadMore(
    LoadMorePlaceEvent event,
    Emitter<CategoryDetailState> emit,
  ) async {
    final res =
        await FetchPlacesByCategory().call(event.categoryId, event.nextPageId);
    emit(CategoryDetailIdleState(
      placeData: res.updateData(
        data: (state.places..addAll(res.data)).toSet().toList(),
      ),
    ));
  }
}
