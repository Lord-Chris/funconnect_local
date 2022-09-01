import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class VerifyEmailEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ResendCodeEvent extends VerifyEmailEvent {}

class PinFieldChangedEvent extends VerifyEmailEvent {}

class VerifyEmailTapEvent extends VerifyEmailEvent {
  final BuildContext context;

  VerifyEmailTapEvent(this.context);
}
