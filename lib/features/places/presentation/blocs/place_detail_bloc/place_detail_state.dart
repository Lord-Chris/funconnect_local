import 'package:equatable/equatable.dart';
import 'package:funconnect/features/places/domain/entities/full_place_model.dart';
import 'package:funconnect/features/places/domain/entities/review_model.dart';

abstract class PlaceDetailState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PlaceDetailFetchingState extends PlaceDetailState {}

class PlaceDetailIdleState extends PlaceDetailState {
  final FullPlaceModel place;
  final List<ReviewModel> reviews;

  PlaceDetailIdleState({
    required this.place,
    this.reviews = const [],
  });

  @override
  List<Object> get props => [place];
}
