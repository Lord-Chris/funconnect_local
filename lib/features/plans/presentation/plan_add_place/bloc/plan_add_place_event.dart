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

class DateSelectedEvent extends PlanAddPlaceEvent {
  final DateTime date;
  const DateSelectedEvent(this.date);

  @override
  List<Object> get props => [];
}

class TimeSelectedEvent extends PlanAddPlaceEvent {
  final TimeOfDay? time;
  const TimeSelectedEvent(this.time);

  @override
  List<Object> get props => [];
}

class AddPlaceEvent extends PlanAddPlaceEvent {
  final String placeId;

  const AddPlaceEvent(this.placeId);
}

class EditPlaceEvent extends PlanAddPlaceEvent {
  final String placeId;

  const EditPlaceEvent(this.placeId);
}

class PlanAddPlaceInitialEvent extends PlanAddPlaceEvent {
  final PLanAddPLaceArguments arguments;

  const PlanAddPlaceInitialEvent({required this.arguments});
}

class PlanEditPlaceSaveChangesEvent extends PlanAddPlaceEvent {
  final String placeId;

  const PlanEditPlaceSaveChangesEvent(this.placeId);
}
