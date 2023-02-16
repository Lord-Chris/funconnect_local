import 'package:equatable/equatable.dart';
import 'package:funconnect/core/models/_models.dart';
import 'package:funconnect/features/places/domain/entities/home_trend_item_model.dart';

import '../../../../authentication/data/dto/user_model.dart';

abstract class HomeState extends Equatable {
  const HomeState();
  @override
  List<Object> get props => [];
}

class HomeLoadingState extends HomeState {}

class HomeSubLoadingState extends HomeState {}

class HomeIdleState extends HomeState {
  final UserModel? user;
  final AppLocation? location;

  final List<String> interests;
  final String? interest;
  final List interestPlaces;
  final List<HomeTrendItemModel> homeTrends;

  const HomeIdleState({
    this.user,
    this.location,
    required this.interests,
    this.interest,
    this.interestPlaces = const [],
    this.homeTrends = const [],
  });

  @override
  List<Object> get props =>
      [interests, interest ?? "", interestPlaces, homeTrends];

  HomeIdleState copyWith({
    UserModel? user,
    AppLocation? location,
    List<String>? interests,
    String? interest,
    List? interestPlaces,
    List<HomeTrendItemModel>? homeTrends,
  }) {
    return HomeIdleState(
      user: user ?? this.user,
      location: location ?? this.location,
      interests: interests ?? this.interests,
      interest: interest ?? this.interest,
      interestPlaces: interestPlaces ?? this.interestPlaces,
      homeTrends: homeTrends ?? this.homeTrends,
    );
  }
}

class HomeFailureState extends HomeState {
  final Failure failure;

  const HomeFailureState({
    required this.failure,
  });

  @override
  List<Object> get props => [failure];
}
