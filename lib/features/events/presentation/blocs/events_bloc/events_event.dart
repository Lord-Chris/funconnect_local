import 'package:equatable/equatable.dart';
import 'package:funconnect/features/events/domain/entities/event_model.dart';

abstract class EventsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class EventInitEvent extends EventsEvent {}

class EventClickedEvent extends EventsEvent {
  final EventModel event;

  EventClickedEvent({
    required this.event,
  });

  @override
  List<Object?> get props => [event];
}

class EventBookmarkedEvent extends EventsEvent {
  final EventModel event;

  EventBookmarkedEvent({
    required this.event,
  });

  @override
  List<Object?> get props => [event];
}
