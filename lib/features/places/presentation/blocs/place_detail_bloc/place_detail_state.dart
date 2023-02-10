import 'package:equatable/equatable.dart';
import 'package:funconnect/features/places/domain/entities/full_place_model.dart';

abstract class PlaceDetailState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PlaceDetailFetchingState extends PlaceDetailState {}

class PlaceDetailIdleState extends PlaceDetailState {
  final FullPlaceModel place;

  PlaceDetailIdleState({
    required this.place,
  });

  @override
  List<Object> get props => [place];
}
