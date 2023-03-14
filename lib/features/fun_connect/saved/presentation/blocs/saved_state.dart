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

class SavedEmptyState extends SavedState{}

class SavedLoadingState extends SavedState {}

class UserSavedPageFilledState extends SavedState {
  final UserModel? user;
  final List<Place> savedPlaces;

 const UserSavedPageFilledState({
    this.user,
    required this.savedPlaces,
  });

  @override
  List<Object> get props => [savedPlaces];

   UserSavedPageFilledState copyWith({
    UserModel? user,
    final List<Place>? savedPlaces,
  }) {
    return UserSavedPageFilledState(
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
