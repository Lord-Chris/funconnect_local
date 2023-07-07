part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();
  @override
  List<Object> get props => [];
}

class ProfileLoadingState extends ProfileState {}

class ProfileSubLoadingState extends ProfileState {}

class ProfileIdleState extends ProfileState {
  final UserModel userProfile;

  const ProfileIdleState({
    required this.userProfile,
  });

  @override
  List<Object> get props => [userProfile, Random().nextInt(1000)];
}

class ProfileFailureState extends ProfileState {
  final Failure failure;

  const ProfileFailureState({
    required this.failure,
  });

  @override
  List<Object> get props => [failure];
}
