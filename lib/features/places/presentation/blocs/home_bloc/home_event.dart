import 'package:equatable/equatable.dart';
import 'package:funconnect/features/places/domain/entities/place_model.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class HomeInitEvent extends HomeEvent {}

class InterestTapEvent extends HomeEvent {
  final String interest;
  const InterestTapEvent({
    required this.interest,
  });

  @override
  List<Object> get props => [interest];
}

class PlaceTapEvent extends HomeEvent {
  final PlaceModel place;

  const PlaceTapEvent({
    required this.place,
  });

  @override
  List<Object> get props => [place];
}

class NotificationTapEvent extends HomeEvent {}
