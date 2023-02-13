import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:funconnect/core/models/_models.dart';
import 'package:funconnect/features/places/domain/entities/full_place_model.dart';
import 'package:funconnect/features/places/domain/entities/review_model.dart';
import 'package:funconnect/features/places/presentation/blocs/place_detail_bloc/place_detail_event.dart';
import 'package:funconnect/features/places/presentation/blocs/place_detail_bloc/place_detail_state.dart';

import '../../../domain/usecases/fetch_place_detail.dart';

class PlaceDetailBloc extends Bloc<PlaceDetailEvent, PlaceDetailState> {
  PlaceDetailBloc() : super(PlaceDetailFetchingState()) {
    on<PlaceInitEvent>(_onPlaceInitEvent);
  }

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
}
