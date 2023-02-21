import 'package:equatable/equatable.dart';
import 'package:funconnect/features/places/domain/entities/category_model.dart';
import 'package:funconnect/features/places/domain/entities/place_model.dart';

abstract class ExploreState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ExploreLoadingState extends ExploreState {}

class ExploreIdleState extends ExploreState {
  final List<PlaceModel> exploreDetails;
  final List<CategoryModel> categories;
  final List<PlaceModel> recentlyAdded;
  final List<PlaceModel> bestRatings;
  ExploreIdleState({
    this.exploreDetails = const [],
    this.categories = const [],
    this.recentlyAdded = const [],
    this.bestRatings = const [],
  });

  @override
  List<Object> get props =>
      [exploreDetails, categories, recentlyAdded, bestRatings];
}
