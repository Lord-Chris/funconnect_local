part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitProfileEvent extends ProfileEvent {}

class EditProfileTapEvent extends ProfileEvent {
  final UserModel userProfile;
  EditProfileTapEvent({required this.userProfile});
}

class ManageLoginOptionsTapEvent extends ProfileEvent {
  final UserModel userProfile;
  ManageLoginOptionsTapEvent({required this.userProfile});
}

class NotificationsTapEvent extends ProfileEvent {}

class RateYourExperienceTapEvent extends ProfileEvent {
  final BuildContext context;
  RateYourExperienceTapEvent({required this.context});
}

class MyTicketTapEvent extends ProfileEvent {}

class MyEventTapEvent extends ProfileEvent {}

class LogoutTapEvent extends ProfileEvent {}

class DeleteTapAccountEvent extends ProfileEvent {}

class TermsOfUseTapEvent extends ProfileEvent {}

class PrivacyPolicyTapEvent extends ProfileEvent {}

class TelegramTapEvent extends ProfileEvent {}

class InstagramTapEvent extends ProfileEvent {}

class TwitterTapEvent extends ProfileEvent {}

class HelpDeskTapEvent extends ProfileEvent {}

class NumberValidationEvent extends ProfileEvent {
  final bool isVerified;

  NumberValidationEvent(this.isVerified);
}
