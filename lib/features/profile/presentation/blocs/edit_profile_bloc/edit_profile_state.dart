part of 'edit_profile_bloc.dart';

class EditProfileState extends Equatable {
  final PageController pageController;
  final int currentIndex;
  final ProfileModel profile;
  const EditProfileState(
      {required this.pageController,required this.currentIndex,required this.profile});

  EditProfileState copyWith({
    PageController? pageController,
    int? currentIndex,
    ProfileModel? profile
  }){
   return EditProfileState(pageController:pageController??this.pageController,currentIndex: currentIndex??this.currentIndex, profile:profile??this.profile);
  }
  @override
  List<Object> get props => [pageController,currentIndex, profile];
}

class EditProfileInitialState extends EditProfileState {
  const EditProfileInitialState(
      {required super.pageController,required super.currentIndex, required super.profile});

  @override
  List<Object> get props => [];
}
