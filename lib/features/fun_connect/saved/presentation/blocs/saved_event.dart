import 'package:equatable/equatable.dart';
import 'package:funconnect/features/places/domain/entities/place_model.dart';

import '../../domain/entities/saved_place_model.dart';

abstract class SavedEvent extends Equatable {
  const SavedEvent();

  @override
  List<Object> get props => [];
}

class SavedInitEvent extends SavedEvent {
  final bool showLoader;
  final Place place;
  const SavedInitEvent({
    this.showLoader = true,
    required this.place,
  });

  @override
  List<Object> get props => [showLoader,place];
}

class SavedPlaceTapEvent extends SavedEvent {
  final Place place;

  const SavedPlaceTapEvent({
    required this.place,
  });

  @override
  List<Object> get props => [place];
}
