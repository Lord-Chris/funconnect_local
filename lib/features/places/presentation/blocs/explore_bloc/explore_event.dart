import 'package:equatable/equatable.dart';

import '../../../domain/entities/category_model.dart';
import '../../../domain/entities/place_model.dart';

abstract class ExploreEvent extends Equatable {
  const ExploreEvent();
  @override
  List<Object?> get props => [];
}

class ExploreInitEvent extends ExploreEvent {}

class PlaceTapEvent extends ExploreEvent {
  final PlaceModel place;

  const PlaceTapEvent({
    required this.place,
  });

  @override
  List<Object> get props => [place];
}

class CategoryTapEvent extends ExploreEvent {
  final CategoryModel category;

  const CategoryTapEvent({
    required this.category,
  });

  @override
  List<Object> get props => [category];
}
