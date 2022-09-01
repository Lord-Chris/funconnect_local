import 'package:equatable/equatable.dart';

abstract class VerifyEmailState extends Equatable {
  @override
  List<Object?> get props => [];
}

class VerifyEmailInitialState extends VerifyEmailState {}

class VerifyEmailLoadingState extends VerifyEmailState {}

class VerifyEmailSuccessState extends VerifyEmailState {}

class VerifyEmailErrorState extends VerifyEmailState {}

class TimerChangedState extends VerifyEmailState {
  final int time;
  TimerChangedState({
    required this.time,
  });

  String get parsedTime {
    final minutes = (time / 60).floor();
    final seconds = (time % 60).floor();

    return '$minutes:$seconds';
  }

  @override
  List<Object?> get props => [time];
}

class TimerFinishedState extends VerifyEmailState {}
