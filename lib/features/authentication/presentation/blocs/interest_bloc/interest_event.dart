import 'package:equatable/equatable.dart';

abstract class InterestsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class InterestTapEvent extends InterestsEvent {}

class ContinueTapEvent extends InterestsEvent {}
