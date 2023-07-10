import 'package:equatable/equatable.dart';
import 'package:funconnect/core/models/_models.dart';
import 'package:funconnect/features/places/domain/entities/place_model.dart';

abstract class CategoryDetailState extends Equatable {
  List<PlaceModel> get places => [];
  @override
  List<Object?> get props => [places];
}

class CategoryDetailLoadingState extends CategoryDetailState {}

class CategoryDetailIdleState extends CategoryDetailState {
  final PaginatedData<PlaceModel> placeData;

  CategoryDetailIdleState({
    required this.placeData,
  });

  @override
  List<PlaceModel> get places => placeData.data;

  @override
  List<Object?> get props => [places];
}

class CategoryDetailFailureState extends CategoryDetailState {
  final Failure failure;

  CategoryDetailFailureState(this.failure);

  @override
  List<Object> get props => [failure];
}
