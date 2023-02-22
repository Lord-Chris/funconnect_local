import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:funconnect/core/app/_app.dart';
import 'package:funconnect/core/models/_models.dart';
import 'package:funconnect/core/utils/general_utils.dart';
import 'package:funconnect/features/places/domain/entities/full_place_model.dart';
import 'package:funconnect/features/places/domain/entities/review_model.dart';
import 'package:funconnect/features/places/domain/usecases/review_place.dart';
import 'package:funconnect/features/places/presentation/blocs/place_detail_bloc/place_detail_event.dart';
import 'package:funconnect/features/places/presentation/blocs/place_detail_bloc/place_detail_state.dart';
import 'package:funconnect/services/_services.dart';
import 'package:logger/logger.dart';

import '../../../domain/usecases/fetch_place_detail.dart';

class PlaceDetailBloc extends Bloc<PlaceDetailEvent, PlaceDetailState> {
  PlaceDetailBloc() : super(PlaceDetailFetchingState()) {
    on<PlaceInitEvent>(_onPlaceInitEvent);
    on<ReviewPlaceEvent>(_onReviewPlaceEvent);
    on<PlaceTapEvent>(_onPlaceTapEvent);
    on<AddressTapEvent>(_onAddressTapEvent);
    on<PhoneTapEvent>(_onPhoneTapEvent);
  }
  final _logger = Logger();
  final _navigationService = locator<INavigationService>();

  Future<FutureOr<void>> _onPlaceInitEvent(
    PlaceInitEvent event,
    Emitter<PlaceDetailState> emit,
  ) async {
    try {
      final data = await FetchPlaceDetail().call(event.place);
      emit(PlaceDetailIdleState(
        place: data[0] as FullPlaceModel,
        reviews: (data[1] as PaginatedData<ReviewModel>).data,
      ));
    } on Failure catch (e) {
      _logger.e(e);
      emit(PlaceDetailFailureState(failure: e));
    }
  }

  FutureOr<void> _onReviewPlaceEvent(
    ReviewPlaceEvent event,
    Emitter<PlaceDetailState> emit,
  ) async {
    if (!event.isValid) return null;
    if (state is! PlaceDetailIdleState) return null;
    final prevState = state as PlaceDetailIdleState;
    try {
      final data = await ReviewPlaceUseCase(prevState.place.id)
          .call(event.toReviewParam());
      emit(PlaceDetailIdleState(
        place: prevState.place,
        reviews: data.data,
      ));
    } on Failure catch (e) {
      _logger.e(e);
      emit(prevState);
    }
  }

  FutureOr<void> _onPlaceTapEvent(
    PlaceTapEvent event,
    Emitter<PlaceDetailState> emit,
  ) {
    _navigationService.toNamed(Routes.placeDetailRoute, arguments: event.place);
  }

  FutureOr<void> _onAddressTapEvent(
    AddressTapEvent event,
    Emitter<PlaceDetailState> emit,
  ) {
    GeneralUtils.openUrl(event.uri);
  }

  FutureOr<void> _onPhoneTapEvent(
    PhoneTapEvent event,
    Emitter<PlaceDetailState> emit,
  ) {
    GeneralUtils.openUrl(event.uri);
  }
}
