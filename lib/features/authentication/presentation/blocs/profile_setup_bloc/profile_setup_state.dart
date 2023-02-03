import 'dart:io';

import 'package:equatable/equatable.dart';

abstract class ProfileSetupState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProfileSetupIdleState extends ProfileSetupState {
  final File? image;
  ProfileSetupIdleState({
    this.image,
  });

  @override
  List<Object> get props => [image?.path ?? ""];
}

class ProfileSetupLoadingState extends ProfileSetupState {}

class ProfileSetupSuccessState extends ProfileSetupState {}

class ProfileSetupErrorState extends ProfileSetupState {}
