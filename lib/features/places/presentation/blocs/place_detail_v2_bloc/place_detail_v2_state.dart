part of 'place_detail_v2_bloc.dart';

abstract class PlaceDetailV2State extends Equatable {
  const PlaceDetailV2State();

  @override
  List<Object> get props => [];
}

class PlaceDetailV2Initial extends PlaceDetailV2State {}

class PlaceDetailsLoaded extends PlaceDetailV2State {
  final FullPlaceModel place;
  final PaginatedData<ReviewModel> reviewsData;

  const PlaceDetailsLoaded({
    required this.place,
    required this.reviewsData,
  });

  @override
  List<Object> get props => [place, reviewsData];
}

class PlaceDetailFailureState extends PlaceDetailV2State {
  final Failure failure;

  const PlaceDetailFailureState({
    required this.failure,
  });

  @override
  List<Object> get props => [failure];
}

class PlaceDetailLoadingState extends PlaceDetailV2State {}
