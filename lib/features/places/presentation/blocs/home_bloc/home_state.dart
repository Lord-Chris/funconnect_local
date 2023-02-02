import 'package:equatable/equatable.dart';
import 'package:funconnect/core/models/_models.dart';

abstract class HomeState extends Equatable {
  const HomeState();
  @override
  List<Object> get props => [];
}

class HomeLoadingState extends HomeState {}

class HomeSubLoadingState extends HomeState {}

class HomeIdleState extends HomeState {
  final List<String> interests;
  final String? interest;
  final List interestPlaces;

  const HomeIdleState({
    required this.interests,
    this.interest,
    this.interestPlaces = const [],
  });

  @override
  List<Object> get props => [interests, interest ?? "", interestPlaces];
}

class HomeFailureState extends HomeState {
  final Failure failure;

  const HomeFailureState({
    required this.failure,
  });

  @override
  List<Object> get props => [failure];
}
