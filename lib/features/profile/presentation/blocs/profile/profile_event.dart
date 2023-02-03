part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class EditMyProfileEvent extends ProfileEvent{

}

class MyTicketEvent extends ProfileEvent{
}

class MyEventEvent extends ProfileEvent{
}

class LogoutEvent extends ProfileEvent{

}

class DeleteAccountEvent extends ProfileEvent{
}
