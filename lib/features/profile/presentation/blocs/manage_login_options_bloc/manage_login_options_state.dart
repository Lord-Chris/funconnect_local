part of 'manage_login_options_bloc.dart';

class ManageLoginOptionsState extends Equatable {
  final bool isUpdatingProfile;
  final ProfileModel profile;

  const ManageLoginOptionsState(
      {required this.profile, required this.isUpdatingProfile});

  ManageLoginOptionsState copyWith({
    ProfileModel? profile,
    bool? isUpdatingProfile,
  }) {
    return ManageLoginOptionsState(
        profile: profile ?? this.profile,
        isUpdatingProfile: isUpdatingProfile ?? this.isUpdatingProfile);
  }

  @override
  List<Object> get props => [profile, isUpdatingProfile];
}

class ManageLoginOptionsInitialState extends ManageLoginOptionsState {
  const ManageLoginOptionsInitialState(
      {required super.profile, required super.isUpdatingProfile});

  @override
  List<Object> get props => [];
}
