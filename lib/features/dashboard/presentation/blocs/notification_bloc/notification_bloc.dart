import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:funconnect/features/dashboard/presentation/blocs/notification_bloc/notification_event.dart';
import 'package:funconnect/features/dashboard/presentation/blocs/notification_bloc/notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc() : super(NotificationLoadingState()) {
    on<NotificationInitEvent>(_onNotificationInitEvent);
    on<NotificationRefreshEvent>(_onNotificationRefreshEvent);
  }

  FutureOr<void> _onNotificationInitEvent(
    NotificationInitEvent event,
    Emitter<NotificationState> emit,
  ) async {
    await Future.delayed(const Duration(seconds: 2));
    emit(NotificationIdleState());
  }

  FutureOr<void> _onNotificationRefreshEvent(
    NotificationRefreshEvent event,
    Emitter<NotificationState> emit,
  ) async {
    emit(NotificationLoadingState());
    await Future.delayed(const Duration(seconds: 2));
    emit(NotificationIdleState());
  }
}
