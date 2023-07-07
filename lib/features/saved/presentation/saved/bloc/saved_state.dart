import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:funconnect/core/models/_models.dart';

import '../../../../places/domain/entities/saved_place_model.dart';

abstract class SavedState extends Equatable {
  const SavedState();

  List<SavedPlaceModel> get savedPlaces => [];

  @override
  List<Object> get props => [savedPlaces];
}

class SavedEmptyState extends SavedState {}

class SavedLoadingState extends SavedState {}

class SavedPageFilledState extends SavedState {
  final UserModel? user;
  final PaginatedData<SavedPlaceModel>? savedPlacesData;

  const SavedPageFilledState({
    this.user,
    this.savedPlacesData,
  });

  @override
  List<SavedPlaceModel> get savedPlaces => savedPlacesData?.data ?? [];

  @override
  List<Object> get props => [savedPlaces, Random().nextInt(2000)];
}

class SavedFailureState extends SavedState {
  final Failure failure;

  const SavedFailureState({
    required this.failure,
  });

  @override
  List<Object> get props => [failure];
}
