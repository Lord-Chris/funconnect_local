import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:funconnect/core/models/_models.dart';
import 'package:funconnect/features/places/domain/entities/full_place_model.dart';
import 'package:funconnect/features/places/domain/entities/review_model.dart';
import 'package:funconnect/features/places/domain/usecases/review_place.dart';
import 'package:funconnect/features/places/presentation/blocs/place_detail_bloc/place_detail_event.dart';
import 'package:funconnect/features/places/presentation/blocs/place_detail_bloc/place_detail_state.dart';
import 'package:logger/logger.dart';

import '../../../domain/usecases/fetch_place_detail.dart';

class PlaceDetailBloc extends Bloc<PlaceDetailEvent, PlaceDetailState> {
  PlaceDetailBloc() : super(PlaceDetailFetchingState()) {
    on<PlaceInitEvent>(_onPlaceInitEvent);
    on<ReviewPlaceEvent>(_onReviewPlaceEvent);
  }
  final _logger = Logger();

  Future<FutureOr<void>> _onPlaceInitEvent(
    PlaceInitEvent event,
    Emitter<PlaceDetailState> emit,
  ) async {
    final data = await FetchPlaceDetail().call(event.place);
    emit(PlaceDetailIdleState(
      place: data[0] as FullPlaceModel,
      reviews: (data[1] as PaginatedData<ReviewModel>).data,
    ));
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
}
