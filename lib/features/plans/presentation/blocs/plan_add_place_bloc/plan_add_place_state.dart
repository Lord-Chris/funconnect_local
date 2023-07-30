part of 'plan_add_place_bloc.dart';

abstract class PlanAddPlaceState extends Equatable {
  const PlanAddPlaceState();

  @override
  List<Object> get props => [];
}

class PlanAddPlaceInitial extends PlanAddPlaceState {}

class PlanPlaceSelected extends PlanAddPlaceState {
  final PlaceModel place;
  const PlanPlaceSelected(this.place);

  @override
  List<Object> get props => [place];
}

class PlanDateSelected extends PlanAddPlaceState {
  final DateTime date;
  const PlanDateSelected(this.date);

  @override
  List<Object> get props => [date];
}

class PlanTimeSelected extends PlanAddPlaceState {
  final DateTime time;
  const PlanTimeSelected(this.time);

  @override
  List<Object> get props => [time];
}
