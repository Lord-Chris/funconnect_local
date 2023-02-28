part of 'manage_login_options_bloc.dart';


abstract class ManageLoginOptionsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class BackTapEvent extends ManageLoginOptionsEvent {}

class LogoutTapEvent extends ManageLoginOptionsEvent {}

class DeleteTapAccountEvent extends ManageLoginOptionsEvent {}
