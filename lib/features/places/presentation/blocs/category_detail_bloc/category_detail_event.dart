import 'package:equatable/equatable.dart';
import 'package:funconnect/features/places/domain/entities/category_model.dart';
import 'package:funconnect/features/places/domain/entities/place_model.dart';

abstract class CategoryDetailEvent extends Equatable {
  const CategoryDetailEvent();

  @override
  List<Object?> get props => [];
}

class CategoryInitEvent extends CategoryDetailEvent {
  final CategoryModel category;

  const CategoryInitEvent(
    this.category,
  );

  @override
  List<Object?> get props => [category];
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
