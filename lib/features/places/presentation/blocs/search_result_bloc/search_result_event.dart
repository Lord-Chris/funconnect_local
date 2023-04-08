import 'package:equatable/equatable.dart';
import 'package:funconnect/features/places/domain/entities/place_model.dart';

abstract class SearchResultEvent extends Equatable {
  const SearchResultEvent();

  @override
  List<Object?> get props => [];
}

class SearchBarChangedEvent extends SearchResultEvent {
  final String query;

  const SearchBarChangedEvent(
    this.query,
  );

  @override
  List<Object?> get props => [query];
}

class PlaceTapEvent extends SearchResultEvent {
  final PlaceModel place;

  const PlaceTapEvent({
    required this.place,
  });

  @override
  List<Object> get props => [place];
}

class ToggleViewSearchResult extends SearchResultEvent {}
