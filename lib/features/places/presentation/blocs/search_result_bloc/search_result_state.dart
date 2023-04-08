import 'package:equatable/equatable.dart';
import 'package:funconnect/core/models/_models.dart';
import 'package:funconnect/features/places/domain/entities/place_model.dart';

abstract class SearchResultState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SearchResultLoadingState extends SearchResultState {}

class SearchResultIdleState extends SearchResultState {
  final PaginatedData<PlaceModel>? placeData;
  final bool showRecents;

  SearchResultIdleState({
    this.showRecents = false,
    this.placeData,
  });

  List<PlaceModel> get places => placeData?.data ?? [];

  @override
  List<Object?> get props => [places, showRecents];

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
