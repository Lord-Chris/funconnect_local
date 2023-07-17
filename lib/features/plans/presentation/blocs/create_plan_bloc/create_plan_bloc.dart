import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:funconnect/core/app/locator.dart';
import 'package:funconnect/features/places/domain/entities/full_place_model.dart';
import 'package:funconnect/features/plans/presentation/blocs/map_bloc/map_bloc.dart';
import 'package:funconnect/features/plans/presentation/views/map_view.dart';
import 'package:funconnect/services/navigation_service/i_navigation_service.dart';

part 'create_plan_event.dart';
part 'create_plan_state.dart';

class CreatePlanBloc extends Bloc<CreatePlanEvent, CreatePlanState> {
  CreatePlanBloc() : super(CreatePlanInitial()) {
    on<CreatePlanEvent>((event, emit) {});
    on<DateSelectTapEvent>(_dateSelectTapEvent);
    on<TimeSelectTapEvent>(_timeSelectTapEvent);
    on<SearchOnMapTapEvent>(_searchOnMapTapEvent);
    on<PlaceSelectedEvent>(_placeSelectedEvent);
  }

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  FullPlaceModel? selectedPlace;
  final _navigation = locator<INavigationService>();

  FutureOr<void> _dateSelectTapEvent(
      DateSelectTapEvent event, Emitter<CreatePlanState> emit) {
    var date = event.selectedDate ?? DateTime.now();
    selectedDate = date;
    emit(DateChangedState(selectedDate: date));
  }

  FutureOr<void> _timeSelectTapEvent(
      TimeSelectTapEvent event, Emitter<CreatePlanState> emit) {
    var time = event.selectedTime ?? TimeOfDay.now();
    selectedTime = time;
    emit(TimeChangedState(selectedTime: time));
  }

  FutureOr<void> _searchOnMapTapEvent(
      SearchOnMapTapEvent event, Emitter<CreatePlanState> emit) async {
    var result = await Navigator.push(
        event.context,
        MaterialPageRoute(
            builder: (context) => BlocProvider(
                create: (context) => MapBloc(), child: const PlannerMapView()),
            fullscreenDialog: true));
    if (result != null) {
      selectedPlace = result as FullPlaceModel;
      emit(PlaceChangedState(selectedPlace: result));
    }
  }

  FutureOr<void> _placeSelectedEvent(
      PlaceSelectedEvent event, Emitter<CreatePlanState> emit) {
    selectedPlace = event.place;
    _navigation.back();
  }
}
