import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:funconnect/core/models/_models.dart';
import 'package:funconnect/features/places/domain/entities/place_model.dart';
import 'package:funconnect/features/places/domain/entities/search_query_param.dart';

abstract class SearchResultState extends Equatable {
  List<PlaceModel> get places => [];
  List<String> get searchHistory => [];
  SearchQueryParam get filter => const SearchQueryParam();
  @override
  List<Object?> get props => [places, searchHistory, filter];
}

class SearchResultLoadingState extends SearchResultState {}

class SearchResultIdleState extends SearchResultState {
  final PaginatedData<PlaceModel>? placeData;
  final bool showRecents;
  final List<String>? searchHistoryData;
  final SearchQueryParam? searchFilter;

  SearchResultIdleState({
    this.placeData,
    this.showRecents = false,
    this.searchHistoryData,
    this.searchFilter,
  });

  @override
  List<PlaceModel> get places => placeData?.data ?? [];

  @override
  List<String> get searchHistory => searchHistoryData ?? [];

  @override
  SearchQueryParam get filter => searchFilter ?? const SearchQueryParam();

  @override
  List<Object?> get props =>
      [places, showRecents, searchHistory, searchFilter, Random().nextDouble()];

  SearchResultIdleState copyWith({
    PaginatedData<PlaceModel>? placeData,
    bool? showRecents,
    List<String>? searchHistoryData,
    SearchQueryParam? searchFilter,
  }) {
    return SearchResultIdleState(
      placeData: placeData ?? this.placeData,
      showRecents: showRecents ?? this.showRecents,
      searchHistoryData: searchHistoryData ?? this.searchHistoryData,
      searchFilter: searchFilter ?? this.searchFilter,
    );
  }
}

class SearchResultFailureState extends SearchResultState {
  final Failure failure;

  SearchResultFailureState(this.failure);

  @override
  List<Object> get props => [failure];
}
