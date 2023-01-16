import 'package:equatable/equatable.dart';
import 'package:funconnect/features/events/domain/entities/event_model.dart';
import 'package:funconnect/models/failure.dart';

abstract class EventsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class EventsLoadingState extends EventsState {}

class EventsIdleState extends EventsState {
  final List<EventModel> events;

  EventsIdleState({
    this.events = const [],
  });

  @override
  List<Object?> get props => [events];
}

class EventsFailureState extends EventsState {
  final Failure failure;

  EventsFailureState({
    required this.failure,
  });

  @override
  List<Object?> get props => [failure];
}
