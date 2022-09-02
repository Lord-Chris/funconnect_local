import 'package:equatable/equatable.dart';

abstract class SplashEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitializeSplashEvent extends SplashEvent {}

class FinishSplashEvent extends SplashEvent {}
