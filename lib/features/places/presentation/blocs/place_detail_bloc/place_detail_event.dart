import 'package:equatable/equatable.dart';
import 'package:funconnect/features/places/domain/entities/place_model.dart';
import 'package:funconnect/features/places/domain/entities/review_model.dart';

abstract class PlaceDetailEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class PlaceInitEvent extends PlaceDetailEvent {
  final PlaceModel place;

  PlaceInitEvent(this.place);

  @override
  List<Object> get props => [place];
}

class ReviewPlaceEvent extends PlaceDetailEvent {
  final int rating;
  final String comment;

  ReviewPlaceEvent({
    this.rating = 0,
    this.comment = "",
  });

  @override
  List<Object?> get props => [rating, comment];

  bool get isValid => rating > 0 && comment.isNotEmpty;
  ReviewParam toReviewParam() {
    return ReviewParam(rating: rating, title: "", comment: comment);
  }
}

class PlaceTapEvent extends PlaceDetailEvent {
  final PlaceModel place;

  PlaceTapEvent({
    required this.place,
  });

  @override
  List<Object> get props => [place];
}
