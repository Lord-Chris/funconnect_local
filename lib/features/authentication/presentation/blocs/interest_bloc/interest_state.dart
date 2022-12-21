import 'package:equatable/equatable.dart';

abstract class InterestsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InterestsInitialState extends InterestsState {}

class InterestsLoadingState extends InterestsState {}

class InterestsSuccessState extends InterestsState {}

class InterestsErrorState extends InterestsState {}
