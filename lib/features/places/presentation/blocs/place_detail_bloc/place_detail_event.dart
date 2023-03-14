import 'package:equatable/equatable.dart';
import 'package:funconnect/core/models/_models.dart';
import 'package:funconnect/features/places/domain/entities/place_location_model.dart';
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
  DeepLinkDataModel get data => DeepLinkDataModel.place(place.id);
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

class AddressTapEvent extends PlaceDetailEvent {
  final PlaceLocationModel location;
  AddressTapEvent({
    required this.location,
  });

  @override
  List<Object> get props => [location];

  Uri get uri => Uri.parse(
      "https://www.google.com/maps/search/?api=1&query=${location.lat},${location.long}");
}

class PhoneTapEvent extends PlaceDetailEvent {
  final String phone;
  PhoneTapEvent({
    required this.phone,
  });

  @override
  List<Object> get props => [phone];

  Uri get uri => Uri.parse("tel://$phone");
}

class ShareTapEvent extends PlaceDetailEvent {
  final PlaceModel place;
  ShareTapEvent(this.place);

  @override
  List<Object> get props => [place];

  DeepLinkDataModel get data => DeepLinkDataModel.place(place.id);
}

class BookRideEvent extends PlaceDetailEvent {}

class BookmarkTapEvent extends PlaceDetailEvent {}
