import 'package:equatable/equatable.dart';
import 'package:funconnect/core/models/_models.dart';
import 'package:funconnect/features/places/domain/entities/category_model.dart';
import 'package:funconnect/features/places/domain/entities/home_category_new.dart';
import 'package:funconnect/features/places/domain/entities/place_model.dart';

import '../../../domain/entities/home_place.dart';
import '../../../domain/entities/home_response_data.dart';

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

  final List<CategoryModel> interests;
  final CategoryModel? interest;
  final List<PlaceModel> interestPlaces;
  final HomeResponseData? homeTrends;

  const HomeIdleState({
    this.user,
    this.location,
    required this.interests,
    this.interest,
    this.interestPlaces = const [],
    this.homeTrends,
  });

  List<HomePlaces> get homePlaces => homeTrends?.places ?? [];
  List<HomeCategory> get homeCategory => homeTrends?.categories ?? [];

  @override
  List<Object> get props => [
        interests,
        interest ?? "",
        interestPlaces,
        homePlaces,
        homeCategory,
        DateTime.now(),
      ];

  HomeIdleState copyWith({
    UserModel? user,
    AppLocation? location,
    List<CategoryModel>? interests,
    CategoryModel? interest,
    List<PlaceModel>? interestPlaces,
    HomeResponseData? homeTrends,
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
