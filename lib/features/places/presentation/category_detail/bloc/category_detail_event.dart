import 'package:equatable/equatable.dart';
import 'package:funconnect/features/places/domain/entities/place_model.dart';

abstract class CategoryDetailEvent extends Equatable {
  const CategoryDetailEvent();

  @override
  List<Object?> get props => [];
}

class CategoryInitEvent extends CategoryDetailEvent {
  final String categoryId;

  const CategoryInitEvent(
    this.categoryId,
  );

  @override
  List<Object?> get props => [categoryId];
}

class PlaceTapEvent extends CategoryDetailEvent {
  final PlaceModel place;

  const PlaceTapEvent({
    required this.place,
  });

  @override
  List<Object> get props => [place];
}

class SearchBarTapEvent extends CategoryDetailEvent {
  const SearchBarTapEvent();
}

class LoadMorePlaceEvent extends CategoryDetailEvent {
  final String categoryId;
  final int nextPageId;

  const LoadMorePlaceEvent(
    this.categoryId,
    this.nextPageId,
  );

  @override
  List<Object?> get props => [categoryId];
}
