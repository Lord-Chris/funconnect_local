part of 'edit_profile_bloc.dart';

abstract class EditProfileEvent extends Equatable {
  @override
  List<Object?> get props => [];
}


class InitEditProfileEvent extends EditProfileEvent{
  InitEditProfileEvent();
}

class BackTapEvent extends EditProfileEvent{

  BackTapEvent();
}

class UpdateProfileEvent extends EditProfileEvent {
  UpdateProfileEvent();
}

class ImageTapEvent extends EditProfileEvent {
  ImageTapEvent();
}

class ContinueTapEvent extends EditProfileEvent {
  ContinueTapEvent();
}

class SkipTapEvent extends EditProfileEvent {
  SkipTapEvent();
}

class CheckMapTapEvent extends EditProfileEvent {
  CheckMapTapEvent();
}

class ChangeLocationTapEvent extends EditProfileEvent {
  ChangeLocationTapEvent();
}

class InterestTapEvent extends EditProfileEvent {
  InterestTapEvent();
}

class EditProfileFieldsEvent extends EditProfileEvent {
  final ProfileModel profileModel;
  EditProfileFieldsEvent(this.profileModel);
}

class PageChangeEvent extends EditProfileEvent {
  final int pageIndex;
  PageChangeEvent(this.pageIndex);
  @override
  List<Object?> get props => [pageIndex];
}
