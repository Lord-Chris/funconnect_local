import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:funconnect/core/usecases/usecase.dart';
import 'package:funconnect/features/events/domain/usecases/fetch_events_usecase.dart';
import 'package:funconnect/features/events/presentation/blocs/events_bloc/events_event.dart';
import 'package:funconnect/features/events/presentation/blocs/events_bloc/events_state.dart';

class EventsBloc extends Bloc<EventsEvent, EventsState> {
  EventsBloc() : super(EventsLoadingState()) {
    on<EventInitEvent>(_onEventInitEvent);
    on<EventClickedEvent>(_onEventClickedEvent);
    on<EventBookmarkedEvent>(_onEventBookmarkedEvent);
  }
  final _fetchEventsUseCase = FetchEventsUsecase();

  Future<FutureOr<void>> _onEventInitEvent(
    EventInitEvent event,
    Emitter<EventsState> emit,
  ) async {
    final res = await _fetchEventsUseCase(NoParams());
    emit(EventsIdleState(events: res));
  }

  FutureOr<void> _onEventClickedEvent(
    EventClickedEvent event,
    Emitter<EventsState> emit,
  ) {}

  FutureOr<void> _onEventBookmarkedEvent(
    EventBookmarkedEvent event,
    Emitter<EventsState> emit,
  ) {}
}
