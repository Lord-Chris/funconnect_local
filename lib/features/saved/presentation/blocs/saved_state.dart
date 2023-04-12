import 'package:equatable/equatable.dart';
import 'package:funconnect/core/models/_models.dart';

import '../../../places/domain/entities/saved_place_model.dart';

abstract class SavedState extends Equatable {
  const SavedState();

  List<SavedPlaceModel> get savedPlaces => [];

  @override
  List<Object> get props => [savedPlaces];
}

class SavedEmptyState extends SavedState {}

class SavedLoadingState extends SavedState {}

class UserSavedPageFilledState extends SavedState {
  final UserModel? user;
  final PaginatedData<SavedPlaceModel> savedPlacesData;

  const UserSavedPageFilledState({
    this.user,
    required this.savedPlacesData,
  });

  @override
  List<SavedPlaceModel> get savedPlaces => savedPlacesData.data;

  @override
  List<Object> get props => [savedPlaces, DateTime.now()];
}

class SavedFailureState extends SavedState {
  final Failure failure;

  const SavedFailureState({
    required this.failure,
  });

  @override
  List<Object> get props => [failure];
}
