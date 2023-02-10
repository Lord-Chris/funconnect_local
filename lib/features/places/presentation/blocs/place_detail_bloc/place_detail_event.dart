import 'package:equatable/equatable.dart';
import 'package:funconnect/features/places/domain/entities/place_model.dart';

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
