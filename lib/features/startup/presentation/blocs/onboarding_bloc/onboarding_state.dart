import 'package:equatable/equatable.dart';

abstract class OnboardingState extends Equatable {
  @override
  List<Object?> get props => [];
}

class OnboardingInitialState extends OnboardingState {
  final int page;
  OnboardingInitialState({
    this.page = 0,
  });
  @override
  List<Object?> get props => [page];
}
