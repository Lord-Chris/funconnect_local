import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:funconnect/core/app/locator.dart';
import 'package:funconnect/core/app/routes.dart';
import 'package:funconnect/features/places/domain/entities/place_model.dart';
import 'package:funconnect/services/navigation_service/i_navigation_service.dart';

part 'plan_add_place_event.dart';
part 'plan_add_place_state.dart';

class PlanAddPlaceBloc extends Bloc<PlanAddPlaceEvent, PlanAddPlaceState> {
  PlanAddPlaceBloc() : super(PlanAddPlaceInitial()) {
    on<PlanAddPlaceEvent>((event, emit) {});
    on<PlanAddPlaceEventClicked>(_planAddPlaceEventClicked);
    on<MapClickedEvent>(_mapClickedEvent);
    on<DateSelectedEvent>(_dateSelectedEvent);
    on<TimeSelectedEvent>(_timeSelectedEvent);
  }
  final _navigation = locator<INavigationService>();
  PlaceModel? selectedPlaceId;
  DateTime? selectedDate;

  FutureOr<void> _planAddPlaceEventClicked(
      PlanAddPlaceEventClicked event, Emitter<PlanAddPlaceState> emit) {
    selectedPlaceId = event.place;
    emit(PlanPlaceSelected(event.place));
  }

  FutureOr<void> _mapClickedEvent(
      MapClickedEvent event, Emitter<PlanAddPlaceState> emit) async {
    PlaceModel selectPlace =
        await _navigation.toNamed(Routes.plannerMapRoute) as PlaceModel;
    selectedPlaceId = selectPlace;
    emit(PlanPlaceSelected(selectPlace));
  }

  FutureOr<void> _dateSelectedEvent(
      DateSelectedEvent event, Emitter<PlanAddPlaceState> emit) {
    selectedDate = event.date;
    emit(PlanDateSelected(event.date));
  }

  FutureOr<void> _timeSelectedEvent(
      TimeSelectedEvent event, Emitter<PlanAddPlaceState> emit) {}
}
