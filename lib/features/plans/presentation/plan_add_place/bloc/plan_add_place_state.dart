part of 'plan_add_place_bloc.dart';

class PlanAddPlaceState extends Equatable {
  final PlaceModel? place;
  final DateTime? date;

  const PlanAddPlaceState({this.place, this.date});

  @override
  List<Object?> get props => [place, date];

  PlanAddPlaceState copyWith({
    PlaceModel? place,
    DateTime? date,
  }) {
    return PlanAddPlaceState(
      place: place ?? this.place,
      date: date ?? this.date,
    );
  }
}

class PlanAddPlaceInitial extends PlanAddPlaceState {}

class PlanAddPlaceLoading extends PlanAddPlaceState {}
