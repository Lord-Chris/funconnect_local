import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:funconnect/core/app/locator.dart';
import 'package:funconnect/core/app/routes.dart';
import 'package:funconnect/services/navigation_service/i_navigation_service.dart';

part 'plan_add_place_event.dart';
part 'plan_add_place_state.dart';

class PlanAddPlaceBloc extends Bloc<PlanAddPlaceEvent, PlanAddPlaceState> {
  PlanAddPlaceBloc() : super(PlanAddPlaceInitial()) {
    on<PlanAddPlaceEvent>((event, emit) {});
    on<PlanAddPlaceEventClicked>(_planAddPlaceEventClicked);
    on<MapClickedEvent>(_mapClickedEvent);
  }
  final _navigation = locator<INavigationService>();
  String selectedPlaceId = "";

  FutureOr<void> _planAddPlaceEventClicked(
      PlanAddPlaceEventClicked event, Emitter<PlanAddPlaceState> emit) {
    selectedPlaceId = event.placeId;
  }

  FutureOr<void> _mapClickedEvent(
      MapClickedEvent event, Emitter<PlanAddPlaceState> emit) {
    _navigation.toNamed(Routes.plannerMapRoute);
  }
}
