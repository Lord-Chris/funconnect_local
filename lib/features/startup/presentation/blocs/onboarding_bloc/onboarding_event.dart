import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

abstract class OnboardingEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class PageChangedEvent extends OnboardingEvent {
  final int page;
  PageChangedEvent({
    required this.page,
  });

  @override
  List<Object?> get props => [page];
}

class GetStartedEvent extends OnboardingEvent {
  final BuildContext context;
  GetStartedEvent(this.context);
}

class LoginTapEvent extends OnboardingEvent {}
