import 'package:equatable/equatable.dart';
import 'package:funconnect/core/models/_models.dart';
import 'package:funconnect/features/places/domain/entities/home_trend_item_model.dart';

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
  final List<HomeTrendItemModel> homeTrends;

  const HomeIdleState({
    required this.interests,
    this.interest,
    this.interestPlaces = const [],
    this.homeTrends = const [],
  });

  @override
  List<Object> get props =>
      [interests, interest ?? "", interestPlaces, homeTrends];
}

class HomeFailureState extends HomeState {
  final Failure failure;

  const HomeFailureState({
    required this.failure,
  });

  @override
  List<Object> get props => [failure];
}
