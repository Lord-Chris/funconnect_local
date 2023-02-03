part of 'edit_profile_bloc.dart';

class EditProfileState extends Equatable {
  final PageController pageController;
  final int currentIndex;
  const EditProfileState(this.pageController, this.currentIndex);
  @override
  List<Object> get props => [pageController,currentIndex];
}

class EditProfileInitialState extends EditProfileState {
  const EditProfileInitialState(super.pageController, super.currentIndex);

  @override
  List<Object> get props => [];
}
