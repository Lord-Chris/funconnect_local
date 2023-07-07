import 'package:equatable/equatable.dart';

abstract class SplashState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SplashInitialState extends SplashState {
  @override
  List<Object?> get props => [];
}

class SplashFinishedState extends SplashState {
  final bool needsUpdate;
  final bool isAuthenticated;
  final bool showOnboarding;

  SplashFinishedState({
    required this.needsUpdate,
    required this.isAuthenticated,
    required this.showOnboarding,
  });
  @override
  List<Object?> get props => [needsUpdate, isAuthenticated, showOnboarding];
}
