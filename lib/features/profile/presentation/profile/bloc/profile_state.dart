part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  @override
  List<Object> get props => [];
}

class ProfileLoadingState extends ProfileState {}

class ProfileSubLoadingState extends ProfileState {}

class ProfileIdleState extends ProfileState {
  final UserModel userProfile;
  final bool isDarkModeEnabled;

  ProfileIdleState({
    required this.userProfile,
    this.isDarkModeEnabled = false,
  });

  ProfileIdleState copyWith({
    UserModel? userProfile,
    bool? isDarkModeEnabled,
  }) {
    return ProfileIdleState(
      userProfile: userProfile ?? this.userProfile,
      isDarkModeEnabled: isDarkModeEnabled ?? this.isDarkModeEnabled,
    );
  }

  @override
  List<Object> get props => [userProfile, Random().nextInt(1000)];
}

class ProfileFailureState extends ProfileState {
  final Failure failure;

  ProfileFailureState({
    required this.failure,
  });

  @override
  List<Object> get props => [failure];
}
