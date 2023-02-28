import 'package:equatable/equatable.dart';
import 'package:funconnect/core/models/_models.dart';
import 'package:funconnect/features/fun_connect/saved/domain/entities/saved_place_model.dart';
import 'package:funconnect/features/places/domain/entities/home_trend_item_model.dart';

import '../../../../authentication/data/dto/user_model.dart';

abstract class SavedState extends Equatable {
  const SavedState();
  @override
  List<Object> get props => [];
}

class SavedLoadingState extends SavedState {}

class SavedLoadingIdleState extends SavedState {
  final PaginatedData<SavedPlaceModel> places;

 const SavedLoadingIdleState({
    required this.places,
  });

  @override
  List<Object> get props => [places];
}


class SavedFailureState extends SavedState {
  final Failure failure;

  const SavedFailureState({
    required this.failure,
  });

  @override
  List<Object> get props => [failure];
}
