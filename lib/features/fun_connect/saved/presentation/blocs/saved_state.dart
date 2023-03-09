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
  final UserModel? user;
  final List<SavedPlaceModel> savedPlaces;

 const SavedLoadingIdleState({
    this.user,
    required this.savedPlaces,
  });

  @override
  List<Object> get props => [savedPlaces];

   SavedLoadingIdleState copyWith({
    UserModel? user,
    final List<SavedPlaceModel>? savedPlaces,
  }) {
    return SavedLoadingIdleState(
      user: user ?? this.user,
      savedPlaces: savedPlaces ?? this.savedPlaces,
     
    );
  }
}


class SavedFailureState extends SavedState {
  final Failure failure;

  const SavedFailureState({
    required this.failure,
  });

  @override
  List<Object> get props => [failure];
}
