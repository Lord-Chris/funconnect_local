import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:funconnect/core/app/locator.dart';
import 'package:funconnect/core/models/_models.dart';
import 'package:funconnect/core/utils/failure_handler.dart';
import 'package:funconnect/features/places/domain/entities/full_place_model.dart';
import 'package:funconnect/features/places/domain/entities/review_model.dart';
import 'package:funconnect/features/places/domain/usecases/bookmark_place.dart';
import 'package:funconnect/features/places/domain/usecases/fetch_place_detail.dart';
import 'package:funconnect/services/dynamic_link_service/i_dynamic_link_service.dart';

import '../../../domain/entities/place_model.dart';

part 'place_detail_v2_event.dart';
part 'place_detail_v2_state.dart';

class PlaceDetailV2Bloc extends Bloc<PlaceDetailV2Event, PlaceDetailV2State> {
  PlaceDetailV2Bloc() : super(PlaceDetailV2Initial()) {
    on<PlaceDetailV2Event>((event, emit) {});
    on<PlaceDetailV2InitEvent>(_onPlaceDetailV2Init);
    on<PlaceDetailShareTapEvent>(_onPlaceDetailShareTapEvent);
    on<PlaceDetailBookmarkTapEvent>(_onPlaceDetailBookmarkTapEvent);
  }

  final _dynamicLinkService = locator<IDynamicLinkService>();

  String? _link;

  Future<void> _getLink(PlaceModel place) async {
    try {
      _link = await _dynamicLinkService.generateLink(
        desc: place.name,
        data: DeepLinkDataModel.place(place.id),
        image: place.coverImagePath,
      );
    } on Failure catch (e, s) {
      FailureHandler.instance.catchError(e, stackTrace: s);
    }
  }

  FutureOr<void> _onPlaceDetailV2Init(
      PlaceDetailV2InitEvent event, Emitter<PlaceDetailV2State> emit) async {
    emit(PlaceDetailLoadingState());
    try {
      await _getLink(event.place);
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

  FutureOr<void> _onPlaceDetailShareTapEvent(
      PlaceDetailShareTapEvent event, Emitter<PlaceDetailV2State> emit) {
    _dynamicLinkService.shareLink(_link!);
  }

  FutureOr<void> _onPlaceDetailBookmarkTapEvent(
      PlaceDetailBookmarkTapEvent event,
      Emitter<PlaceDetailV2State> emit) async {
    try {
      var data = await BookmarkPlace().call(event.place);
      final loadedState = state as PlaceDetailsLoaded;

      emit(loadedState.copyWith(place: data));
    } on Failure catch (e, s) {
      FailureHandler.instance.catchError(e, stackTrace: s);
    }
  }
}
