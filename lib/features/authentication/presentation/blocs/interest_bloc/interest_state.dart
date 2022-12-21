import 'package:equatable/equatable.dart';

abstract class InterestsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InterestsInitialState extends InterestsState {
  final List<String> interests;
  final List<String> selectedInterest;

  InterestsInitialState({
    required this.interests,
    required this.selectedInterest,
  });

  @override
  List<Object?> get props => [interests, selectedInterest];
}

class InterestsLoadingState extends InterestsState {}

class InterestsSuccessState extends InterestsState {}

class InterestsErrorState extends InterestsState {}
