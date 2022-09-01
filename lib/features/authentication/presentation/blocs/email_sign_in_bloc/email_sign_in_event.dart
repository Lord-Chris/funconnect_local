import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class EmailSignInEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class EmailFieldChangeEvent extends EmailSignInEvent {}

class GetCodeEvent extends EmailSignInEvent {
  final BuildContext context;

  GetCodeEvent(this.context);
}
