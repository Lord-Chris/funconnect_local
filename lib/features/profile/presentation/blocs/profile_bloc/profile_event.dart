part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class EditProfileTapEvent extends ProfileEvent{

}
class ManageLoginOptionsTapEvent extends ProfileEvent{

}

class MyTicketTapEvent extends ProfileEvent{
}

class MyEventTapEvent extends ProfileEvent{
}

class LogoutTapEvent extends ProfileEvent{

}

class DeleteTapAccountEvent extends ProfileEvent{
}
