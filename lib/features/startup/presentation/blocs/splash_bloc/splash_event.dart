import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class SplashEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitializeSplashEvent extends SplashEvent {}

class FinishSplashEvent extends SplashEvent {
  final BuildContext context;
  FinishSplashEvent({
    required this.context,
  });
}
