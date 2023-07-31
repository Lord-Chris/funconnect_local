import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:funconnect/core/app/locator.dart';
import 'package:funconnect/core/app/routes.dart';

import 'package:funconnect/features/places/domain/entities/place_model.dart';
import 'package:funconnect/features/plans/domain/params/add_place.dart';
import 'package:funconnect/features/plans/domain/usecases/add_plan_place_usecase.dart';
import 'package:funconnect/services/navigation_service/i_navigation_service.dart';
import 'package:logger/logger.dart';

part 'plan_add_place_event.dart';
part 'plan_add_place_state.dart';

class PlanAddPlaceBloc extends Bloc<PlanAddPlaceEvent, PlanAddPlaceState> {
  PlanAddPlaceBloc() : super(PlanAddPlaceInitial()) {
    on<PlanAddPlaceEvent>((event, emit) {});
    on<PlanAddPlaceEventClicked>(_planAddPlaceEventClicked);
    on<MapClickedEvent>(_mapClickedEvent);
    on<DateSelectedEvent>(_dateSelectedEvent);
    on<TimeSelectedEvent>(_timeSelectedEvent);
    on<AddPlaceEvent>(_addPlaceEvent);
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
    emit(PlanDateSelected(selectedDate ?? DateTime.now()));
  }

  FutureOr<void> _timeSelectedEvent(
      TimeSelectedEvent event, Emitter<PlanAddPlaceState> emit) {
    DateTime? date;
    if (selectedDate == null) {
      date = DateTime.now();
    } else {
      date = selectedDate;
    }
    selectedDate = DateTime(date!.year, date.month, date.day,
        event.time?.hour ?? date.hour, event.time?.minute ?? date.minute);
    emit(PlanTimeSelected(selectedDate ?? DateTime.now()));
  }

  FutureOr<void> _addPlaceEvent(
      AddPlaceEvent event, Emitter<PlanAddPlaceState> emit) async {
    try {
      final data = await AddPlanPlaceUsecase().call(AddPlaceParams(
        placeId: selectedPlaceId?.id ?? "",
        miniPlanId: event.placeId,
        date: selectedDate?.toUtc().millisecondsSinceEpoch ??
            DateTime.now().toUtc().millisecondsSinceEpoch,
      ));
    } catch (e) {
      Logger().e(e.toString());
    }
  }
}
