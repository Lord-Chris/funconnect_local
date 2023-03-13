import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:funconnect/core/usecases/usecase.dart';
import 'package:funconnect/features/dashboard/domain/usecases/fetch_notifications.dart';
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
    final res = await FetchNotifications().call(NoParams());
    emit(NotificationIdleState(notificationData: res));
    await Future.delayed(const Duration(seconds: 2));
    final updatedRes = await ReadAllNotifications().call(NoParams());
    emit(NotificationIdleState(notificationData: updatedRes));
  }

  FutureOr<void> _onNotificationRefreshEvent(
    NotificationRefreshEvent event,
    Emitter<NotificationState> emit,
  ) async {
    final res = await FetchNotifications().call(NoParams());
    emit(NotificationIdleState(notificationData: res));
    await Future.delayed(const Duration(seconds: 2));
    final updatedRes = await ReadAllNotifications().call(NoParams());
    emit(NotificationIdleState(notificationData: updatedRes));
  }
}
