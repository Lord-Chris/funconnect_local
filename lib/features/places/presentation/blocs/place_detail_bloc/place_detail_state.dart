import 'package:equatable/equatable.dart';
import 'package:funconnect/core/models/_models.dart';
import 'package:funconnect/features/places/domain/entities/full_place_model.dart';
import 'package:funconnect/features/places/domain/entities/review_model.dart';

abstract class PlaceDetailState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PlaceDetailFetchingState extends PlaceDetailState {}

class PlaceDetailIdleState extends PlaceDetailState {
  final FullPlaceModel place;
  final PaginatedData<ReviewModel>? reviewsData;

  PlaceDetailIdleState({
    required this.place,
    this.reviewsData,
  });

  @override
  List<Object> get props => [place, reviews];

  List<ReviewModel> get reviews => reviewsData?.data ?? [];
}

class PlaceDetailFailureState extends PlaceDetailState {
  final Failure failure;

  PlaceDetailFailureState({
    required this.failure,
  });

  @override
  List<Object?> get props => [failure];
}
