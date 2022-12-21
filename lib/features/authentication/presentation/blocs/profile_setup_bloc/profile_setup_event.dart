import 'package:equatable/equatable.dart';
import 'package:funconnect/features/authentication/domain/params/profile_setup.dart';

abstract class ProfileSetupEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddImageEvent extends ProfileSetupEvent {}

class ShareLocationEvent extends ProfileSetupEvent {}

class SetupProfileEvent extends ProfileSetupEvent {
  final String fullName;
  final String username;
  final String gender;

  SetupProfileEvent({
    required this.fullName,
    required this.username,
    required this.gender,
  });

  ProfileSetupParam get param => ProfileSetupParam(
        name: fullName,
        username: username,
        gender: gender,
      );
}
