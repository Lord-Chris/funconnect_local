part of 'edit_profile_bloc.dart';

class EditProfileState extends Equatable {
  final PageController pageController;
  final int currentIndex;
  final bool isUpdatingProfile;
  final UserModel profile;
  final bool autoValidateForm;

  const EditProfileState({
    required this.pageController,
    required this.currentIndex,
    required this.profile,
    required this.isUpdatingProfile,
    required this.autoValidateForm,
  });

  EditProfileState copyWith({
    PageController? pageController,
    int? currentIndex,
    UserModel? profile,
    bool? isUpdatingProfile,
    bool? autoValidateForm,
  }) {
    return EditProfileState(
      pageController: pageController ?? this.pageController,
      currentIndex: currentIndex ?? this.currentIndex,
      profile: profile ?? this.profile,
      isUpdatingProfile: isUpdatingProfile ?? this.isUpdatingProfile,
      autoValidateForm: autoValidateForm ?? this.autoValidateForm,
    );
  }

  @override
  List<Object> get props => [
        pageController,
        currentIndex,
        profile,
        isUpdatingProfile,
        autoValidateForm
      ];
}

class EditProfileInitialState extends EditProfileState {
  const EditProfileInitialState({
    required super.pageController,
    required super.currentIndex,
    required super.profile,
    required super.isUpdatingProfile,
    required super.autoValidateForm,
  });

  @override
  List<Object> get props => [];
}
