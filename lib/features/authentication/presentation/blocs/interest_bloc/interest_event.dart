import 'package:equatable/equatable.dart';
import 'package:funconnect/features/authentication/data/dto/interest_model.dart';

abstract class InterestsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadInterestsEvent extends InterestsEvent {}

class InterestTapEvent extends InterestsEvent {
  final InterestModel interest;
  InterestTapEvent({
    required this.interest,
  });
}

class ContinueTapEvent extends InterestsEvent {
  final List<InterestModel> interests;

  ContinueTapEvent({
    required this.interests,
  });

  @override
  List<Object> get props => [interests];
}

class SkipTapEvent extends InterestsEvent {}
