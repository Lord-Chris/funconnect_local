import 'package:equatable/equatable.dart';

abstract class ProfileSetupState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProfileSetupInitialState extends ProfileSetupState {}

class ProfileSetupLoadingState extends ProfileSetupState {}

class ProfileSetupSuccessState extends ProfileSetupState {}

class ProfileSetupErrorState extends ProfileSetupState {}
