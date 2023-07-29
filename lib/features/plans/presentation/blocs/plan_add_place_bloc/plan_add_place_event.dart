part of 'plan_add_place_bloc.dart';

abstract class PlanAddPlaceEvent extends Equatable {
  const PlanAddPlaceEvent();

  @override
  List<Object> get props => [];
}

class PlanAddPlaceEventClicked extends PlanAddPlaceEvent {
  final String placeId;
  const PlanAddPlaceEventClicked(this.placeId);

  @override
  List<Object> get props => [placeId];
}

class MapClickedEvent extends PlanAddPlaceEvent {
  const MapClickedEvent();

  @override
  List<Object> get props => [];
}
