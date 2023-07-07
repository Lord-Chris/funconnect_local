part of 'manage_login_options_bloc.dart';

abstract class ManageLoginOptionsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ManageLoginInitEvent extends ManageLoginOptionsEvent {}

class ToggleEmailLogInEvent extends ManageLoginOptionsEvent {
  final bool value;

  ToggleEmailLogInEvent(this.value);

  @override
  List<Object> get props => [value];
}

class ToggleAppleLogInEvent extends ManageLoginOptionsEvent {
  final bool value;

  ToggleAppleLogInEvent(this.value);

  @override
  List<Object> get props => [value];
}

class ToggleGoogleLogInEvent extends ManageLoginOptionsEvent {
  final bool value;

  ToggleGoogleLogInEvent(this.value);

  @override
  List<Object> get props => [value];
}

class BackTapEvent extends ManageLoginOptionsEvent {}

class LogoutTapEvent extends ManageLoginOptionsEvent {}

class DeleteTapAccountEvent extends ManageLoginOptionsEvent {}
