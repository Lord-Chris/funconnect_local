import 'package:equatable/equatable.dart';

abstract class WelcomeState extends Equatable {
  @override
  List<Object?> get props => [];
}

class WelcomeInitialState extends WelcomeState {}

class WelcomeLoadingState extends WelcomeState {}

class WelcomeSuccessState extends WelcomeState {}

class WelcomeFailureState extends WelcomeState {}
