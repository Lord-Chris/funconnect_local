import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:funconnect/core/app/locator.dart';
import 'package:funconnect/core/app/routes.dart';

import 'package:funconnect/features/places/domain/entities/place_model.dart';
import 'package:funconnect/features/plans/domain/entities/plan_add_place_arguments.dart';
import 'package:funconnect/features/plans/domain/params/add_place.dart';
import 'package:funconnect/features/plans/domain/usecases/add_plan_place_usecase.dart';
import 'package:funconnect/features/plans/domain/usecases/update_mini_plan_usecase.dart';
import 'package:funconnect/services/navigation_service/i_navigation_service.dart';
import 'package:intl/intl.dart';
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
    on<PlanAddPlaceInitialEvent>(_addPlaceInitial);
    on<PlanEditPlaceSaveChangesEvent>(_saveChangesEvent);
  }
  final _navigation = locator<INavigationService>();
  PlaceModel? selectedPlaceId;
  DateTime? selectedDate;

  FutureOr<void> _planAddPlaceEventClicked(
      PlanAddPlaceEventClicked event, Emitter<PlanAddPlaceState> emit) {
    selectedPlaceId = event.place;
    emit(state.copyWith(place: event.place));
  }

  FutureOr<void> _mapClickedEvent(
      MapClickedEvent event, Emitter<PlanAddPlaceState> emit) async {
    PlaceModel selectPlace =
        await _navigation.toNamed(Routes.plannerMapRoute) as PlaceModel;
    selectedPlaceId = selectPlace;
    emit(state.copyWith(place: selectPlace));
  }

  FutureOr<void> _dateSelectedEvent(
      DateSelectedEvent event, Emitter<PlanAddPlaceState> emit) {
    selectedDate = event.date;
    emit(state.copyWith(date: selectedDate ?? DateTime.now()));
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
    emit(state.copyWith(date: selectedDate ?? DateTime.now()));
  }

  FutureOr<void> _addPlaceEvent(
      AddPlaceEvent event, Emitter<PlanAddPlaceState> emit) async {
    emit(PlanAddPlaceLoading());
    try {
      await AddPlanPlaceUsecase().call(AddPlaceParams(
        placeId: selectedPlaceId?.id ?? "",
        miniPlanId: event.placeId,
        date: selectedDate?.millisecondsSinceEpoch ??
            DateTime.now().millisecondsSinceEpoch,
      ));
      _navigation.back(true);
    } catch (e) {
      Logger().e(e.toString());
    }
  }

  FutureOr<void> _addPlaceInitial(
      PlanAddPlaceInitialEvent event, Emitter<PlanAddPlaceState> emit) {
    emit(state.copyWith(
        date: event.arguments.selectedPlace != null
            ? DateFormat("yyyy-MM-dd HH:mm:ss")
                .parse(event.arguments.selectedPlace!.dateTime, true)
                .toLocal()
            : null,
        place: event.arguments.place?.toPlaceModel()));
  }

  FutureOr<void> _saveChangesEvent(PlanEditPlaceSaveChangesEvent event,
      Emitter<PlanAddPlaceState> emit) async {
    emit(PlanAddPlaceLoading());
    try {
      await UpdateMiniPlan().call(AddPlaceParams(
        placeId: selectedPlaceId?.id ?? "",
        miniPlanId: event.placeId,
        date: selectedDate?.millisecondsSinceEpoch ??
            DateTime.now().millisecondsSinceEpoch,
      ));
    } catch (e) {
      Logger().e(e.toString());
    }
  }
}
