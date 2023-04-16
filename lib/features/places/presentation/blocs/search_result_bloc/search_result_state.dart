import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:funconnect/core/models/_models.dart';
import 'package:funconnect/features/places/domain/entities/place_model.dart';

abstract class SearchResultState extends Equatable {
  List<PlaceModel> get places => [];
  List<String> get searchHistory => [];
  @override
  List<Object?> get props => [places, searchHistory];
}

class SearchResultLoadingState extends SearchResultState {}

class SearchResultIdleState extends SearchResultState {
  final PaginatedData<PlaceModel>? placeData;
  final bool showRecents;
  final List<String>? searchHistoryData;

  SearchResultIdleState({
    this.showRecents = false,
    this.placeData,
    this.searchHistoryData,
  });

  @override
  List<PlaceModel> get places => placeData?.data ?? [];

  @override
  List<String> get searchHistory => searchHistoryData ?? [];

  @override
  List<Object?> get props =>
      [places, showRecents, searchHistory, Random().nextDouble()];

  SearchResultIdleState copyWith({
    PaginatedData<PlaceModel>? placeData,
    bool? showRecents,
    List<String>? searchHistoryData,
  }) {
    return SearchResultIdleState(
      placeData: placeData ?? this.placeData,
      showRecents: showRecents ?? this.showRecents,
      searchHistoryData: searchHistoryData ?? this.searchHistoryData,
    );
  }
}

class SearchResultFailureState extends SearchResultState {
  final Failure failure;

  SearchResultFailureState(this.failure);

  @override
  List<Object> get props => [failure];
}
