import 'package:equatable/equatable.dart';
import 'package:funconnect/core/models/_models.dart';
import 'package:funconnect/features/places/domain/entities/category_model.dart';
import 'package:funconnect/features/places/domain/entities/place_model.dart';

abstract class ExploreState extends Equatable {
  List<PlaceModel> get exploreDetails => [];
  List<CategoryModel> get categories => [];
  List<PlaceModel> get recentlyAdded => [];
  List<PlaceModel> get bestRatings => [];

  @override
  List<Object?> get props =>
      [exploreDetails, categories, recentlyAdded, bestRatings];
}

class ExploreLoadingState extends ExploreState {}

class ExploreIdleState extends ExploreState {
  final PaginatedData<PlaceModel>? exploreDetailsData;
  final PaginatedData<CategoryModel>? categoriesData;
  final PaginatedData<PlaceModel>? recentlyAddedData;
  final PaginatedData<PlaceModel>? bestRatingsData;
  ExploreIdleState({
    this.exploreDetailsData,
    this.categoriesData,
    this.recentlyAddedData,
    this.bestRatingsData,
  });

  @override
  List<PlaceModel> get exploreDetails => exploreDetailsData?.data ?? [];
  @override
  List<CategoryModel> get categories => categoriesData?.data ?? [];
  @override
  List<PlaceModel> get recentlyAdded => recentlyAddedData?.data ?? [];
  @override
  List<PlaceModel> get bestRatings => bestRatingsData?.data ?? [];

  @override
  List<Object> get props =>
      [exploreDetails, categories, recentlyAdded, bestRatings];
}

class ExploreFailureState extends ExploreState {
  final Failure failure;
  ExploreFailureState(this.failure);

  @override
  List<Object> get props => [failure];
}
