import 'package:equatable/equatable.dart';
import 'package:funconnect/core/app/_app.dart';

import '../../../data/repositories/_authentication_repo.dart';

abstract class WelcomeState extends Equatable {
  final _authenticationRepo = locator<IAuthenticationRepository>();

  bool get isFirstTime => _authenticationRepo.isFirstTime;

  @override
  List<Object?> get props => [isFirstTime];
}

class WelcomeInitialState extends WelcomeState {}

class WelcomeLoadingState extends WelcomeState {}

class WelcomeSuccessState extends WelcomeState {}

class WelcomeFailureState extends WelcomeState {}
