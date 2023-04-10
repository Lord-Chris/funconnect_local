import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:funconnect/core/models/_models.dart';
import 'package:funconnect/features/places/domain/entities/place_model.dart';

abstract class SearchResultState extends Equatable {
  List<PlaceModel> get places => [];
  @override
  List<Object?> get props => [places];
}

class SearchResultLoadingState extends SearchResultState {}

class SearchResultIdleState extends SearchResultState {
  final PaginatedData<PlaceModel>? placeData;
  final bool showRecents;

  SearchResultIdleState({
    this.showRecents = false,
    this.placeData,
  });

  @override
  List<PlaceModel> get places => placeData?.data ?? [];

  @override
  List<Object?> get props => [places, showRecents, Random().nextDouble()];

  SearchResultIdleState copyWith({
    PaginatedData<PlaceModel>? placeData,
    bool? showRecents,
  }) {
    return SearchResultIdleState(
      placeData: placeData ?? this.placeData,
      showRecents: showRecents ?? this.showRecents,
    );
  }
}
