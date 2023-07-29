part of 'plan_add_place_bloc.dart';

abstract class PlanAddPlaceEvent extends Equatable {
  const PlanAddPlaceEvent();

  @override
  List<Object> get props => [];
}

class PlanAddPlaceEventClicked extends PlanAddPlaceEvent {
  final PlaceModel place;
  const PlanAddPlaceEventClicked(this.place);
}

class MapClickedEvent extends PlanAddPlaceEvent {
  const MapClickedEvent();

  @override
  List<Object> get props => [];
}
