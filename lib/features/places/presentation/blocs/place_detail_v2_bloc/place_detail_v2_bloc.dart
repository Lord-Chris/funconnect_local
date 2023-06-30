import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:funconnect/core/models/_models.dart';
import 'package:funconnect/core/utils/failure_handler.dart';
import 'package:funconnect/features/places/domain/entities/full_place_model.dart';
import 'package:funconnect/features/places/domain/entities/home_places_data.dart';
import 'package:funconnect/features/places/domain/entities/review_model.dart';
import 'package:funconnect/features/places/domain/usecases/fetch_place_detail.dart';

part 'place_detail_v2_event.dart';
part 'place_detail_v2_state.dart';

class PlaceDetailV2Bloc extends Bloc<PlaceDetailV2Event, PlaceDetailV2State> {
  PlaceDetailV2Bloc() : super(PlaceDetailV2Initial()) {
    on<PlaceDetailV2Event>((event, emit) {});
    on<PlaceDetailV2InitEvent>(_onPlaceDetailV2Init);
  }

  FutureOr<void> _onPlaceDetailV2Init(
      PlaceDetailV2InitEvent event, Emitter<PlaceDetailV2State> emit) async {
    emit(PlaceDetailLoadingState());
    try {
      final data = await FetchPlaceDetail().call(event.place.id);
      emit(PlaceDetailsLoaded(
        place: data[0] as FullPlaceModel,
        reviewsData: data[1] as PaginatedData<ReviewModel>,
      ));
    } on Failure catch (e, s) {
      FailureHandler.instance.catchError(e, stackTrace: s);
      emit(PlaceDetailFailureState(failure: e));
    }
  }
}
