import 'package:equatable/equatable.dart';

abstract class InterestsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class InterestTapEvent extends InterestsEvent {
  final String interest;
  InterestTapEvent({
    required this.interest,
  });
}

class ContinueTapEvent extends InterestsEvent {}
