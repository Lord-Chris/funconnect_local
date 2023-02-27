part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitProfileEvent extends ProfileEvent {}

class EditProfileTapEvent extends ProfileEvent{
  final ProfileModel userProfile;
  EditProfileTapEvent({required this.userProfile});

}
class ManageLoginOptionsTapEvent extends ProfileEvent{

}
class NotificationsTapEvent extends ProfileEvent{

}


class RateYourExperienceTapEvent extends ProfileEvent {}

class MyTicketTapEvent extends ProfileEvent {}

class MyEventTapEvent extends ProfileEvent {}

class LogoutTapEvent extends ProfileEvent {}

class DeleteTapAccountEvent extends ProfileEvent {}
