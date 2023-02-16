import 'package:equatable/equatable.dart';
import 'package:funconnect/core/models/_models.dart';
import 'package:funconnect/features/places/domain/entities/place_model.dart';

abstract class CategoryDetailState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CategoryDetailLoadingState extends CategoryDetailState {}

class CategoryDetailIdleState extends CategoryDetailState {
  final PaginatedData<PlaceModel> places;

  CategoryDetailIdleState({
    required this.places,
  });

  @override
  List<Object?> get props => [places];
}
