part of 'edit_profile_bloc.dart';

abstract class EditProfileEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class BackTapEvent extends EditProfileEvent{
  BackTapEvent();
}

class UpdateProfileEvent extends EditProfileEvent{
  UpdateProfileEvent();
}

class ContinueTapEvent extends EditProfileEvent{
  ContinueTapEvent();
}

class PageChangeEvent extends EditProfileEvent{
  final int pageIndex;
  PageChangeEvent(this.pageIndex);
  @override
  List<Object?> get props => [pageIndex];
}
