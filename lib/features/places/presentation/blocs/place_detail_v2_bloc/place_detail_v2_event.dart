part of 'place_detail_v2_bloc.dart';

abstract class PlaceDetailV2Event extends Equatable {
  const PlaceDetailV2Event();

  @override
  List<Object> get props => [];
}

class PlaceDetailV2InitEvent extends PlaceDetailV2Event {
  final HomePlacesData place;

  const PlaceDetailV2InitEvent({required this.place});
}