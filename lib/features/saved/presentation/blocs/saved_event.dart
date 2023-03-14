import 'package:equatable/equatable.dart';
import 'package:funconnect/features/places/domain/entities/saved_place_model.dart';

abstract class SavedEvent extends Equatable {
  const SavedEvent();

  @override
  List<Object> get props => [];
}

class GetAllUserSavedPlaces extends SavedEvent {
  final bool showLoader;

  const GetAllUserSavedPlaces({
    this.showLoader = true,
  });

  @override
  List<Object> get props => [showLoader];
}

class SavedPlaceTapEvent extends SavedEvent {
  final SavedPlaceModel place;

  const SavedPlaceTapEvent({
    required this.place,
  });

  @override
  List<Object> get props => [place];
}
