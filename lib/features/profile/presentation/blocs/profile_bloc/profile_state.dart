part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();
  @override
  List<Object> get props => [];
}


class ProfileLoadingState extends ProfileState {}

class ProfileSubLoadingState extends ProfileState {}

class ProfileIdleState extends ProfileState {
  final ProfileModel userProfile;

  const ProfileIdleState({
    required this.userProfile,
  });

  @override
  List<Object> get props =>
      [userProfile];
}

class ProfileFailureState extends ProfileState {
  final Failure failure;

  const ProfileFailureState({
    required this.failure,
  });

  @override
  List<Object> get props => [failure];
}
