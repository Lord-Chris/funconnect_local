part of 'edit_profile_bloc.dart';

class EditProfileState extends Equatable {
  final PageController pageController;
  final int currentIndex;
  final bool isUpdatingProfile;
  final ProfileModel profile;
  const EditProfileState(
      {required this.pageController,required this.currentIndex,required this.profile, required this.isUpdatingProfile});

  EditProfileState copyWith({
    PageController? pageController,
    int? currentIndex,
    ProfileModel? profile,
    bool? isUpdatingProfile,
  }){
   return EditProfileState(pageController:pageController??this.pageController,currentIndex: currentIndex??this.currentIndex, profile:profile??this.profile, isUpdatingProfile: isUpdatingProfile?? this.isUpdatingProfile);
  }

  @override
  List<Object> get props => [pageController, currentIndex, profile, isUpdatingProfile];
}

class EditProfileInitialState extends EditProfileState {
  const EditProfileInitialState(

      {required super.pageController,required super.currentIndex, required super.profile, required super.isUpdatingProfile});


  @override
  List<Object> get props => [];
}
