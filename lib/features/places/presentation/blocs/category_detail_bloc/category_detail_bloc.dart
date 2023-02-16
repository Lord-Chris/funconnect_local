import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:funconnect/core/app/_app.dart';
import 'package:funconnect/features/places/presentation/blocs/category_detail_bloc/category_detail_event.dart';
import 'package:funconnect/features/places/presentation/blocs/category_detail_bloc/category_detail_state.dart';
import 'package:funconnect/services/_services.dart';

import '../../../domain/usecases/fetch_places.dart';

class CategoryDetailBloc
    extends Bloc<CategoryDetailEvent, CategoryDetailState> {
  CategoryDetailBloc() : super(CategoryDetailLoadingState()) {
    on<CategoryInitEvent>(_onCategoryInitEvent);
    on<PlaceTapEvent>(_onPlaceTapEvent);
    on<SearchEvent>(_onSearchEvent);
  }
  final _navigationService = locator<INavigationService>();

  FutureOr<void> _onCategoryInitEvent(
    CategoryInitEvent event,
    Emitter<CategoryDetailState> emit,
  ) async {
    final res = await FetchPlacesByCategory().call(event.category);
    emit(CategoryDetailIdleState(places: res));
  }

  FutureOr<void> _onPlaceTapEvent(
    PlaceTapEvent event,
    Emitter<CategoryDetailState> emit,
  ) {
    _navigationService.toNamed(Routes.placeDetailRoute, arguments: event.place);
  }

  FutureOr<void> _onSearchEvent(
    SearchEvent event,
    Emitter<CategoryDetailState> emit,
  ) {}
}
