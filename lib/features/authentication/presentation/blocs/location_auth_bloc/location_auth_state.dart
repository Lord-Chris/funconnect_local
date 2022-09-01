import 'package:equatable/equatable.dart';

abstract class LocationAuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LocationAuthInitialState extends LocationAuthState {}

class LocationAuthLoadingState extends LocationAuthState {}

class LocationAuthSuccessState extends LocationAuthState {}

class LocationAuthErrorState extends LocationAuthState {}
