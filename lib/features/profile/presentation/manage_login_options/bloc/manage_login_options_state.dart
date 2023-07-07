part of 'manage_login_options_bloc.dart';

class ManageLoginOptionsState extends Equatable {
  final UserModel profile;
  final bool? isUpdatingProfile;
  final LoginOptionsData? loginOptions;

  const ManageLoginOptionsState({
    required this.profile,
    this.isUpdatingProfile,
    this.loginOptions,
  });

  ManageLoginOptionsState copyWith({
    UserModel? profile,
    bool? isUpdatingProfile,
    LoginOptionsData? loginOptions,
  }) {
    return ManageLoginOptionsState(
      profile: profile ?? this.profile,
      isUpdatingProfile: isUpdatingProfile ?? isUpdatingProfile,
      loginOptions: loginOptions ?? loginOptions,
    );
  }

  bool get isLoading => isUpdatingProfile ?? false;
  LoginOptionsData get loginOptionsData =>
      loginOptions ?? const LoginOptionsData.initial();

  @override
  List<Object> get props => [profile, isLoading, loginOptionsData];
}

// class ManageLoginOptionsInitialState extends ManageLoginOptionsState {
//   const ManageLoginOptionsInitialState({
//     required super.profile,
//     required super.isUpdatingProfile,
//   });

//   ManageLoginOptionsInitialState copyWith({
//     UserModel? profile,
//     bool? isUpdatingProfile,
//   }) {
//     return ManageLoginOptionsInitialState(
//       profile: profile ?? this.profile,
//       isUpdatingProfile: isUpdatingProfile ?? this.isUpdatingProfile,
//     );
//   }

//   @override
//   List<Object> get props => [profile, isUpdatingProfile];
// }
