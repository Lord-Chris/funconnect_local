import 'package:equatable/equatable.dart';

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

class PlaceTapEvent extends HomeEvent {}
