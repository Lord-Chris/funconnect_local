import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:funconnect/core/models/failure.dart';
import 'package:funconnect/core/usecases/usecase.dart';
import 'package:funconnect/features/dashboard/domain/entities/notification_model.dart';
import 'package:funconnect/features/dashboard/domain/usecases/fetch_notifications.dart';
import 'package:funconnect/features/dashboard/presentation/blocs/notification_bloc/notification_event.dart';
import 'package:funconnect/features/dashboard/presentation/blocs/notification_bloc/notification_state.dart';
import 'package:funconnect/services/_services.dart';
import 'package:logger/logger.dart';

import '../../../../../core/app/_app.dart';
import '../../../../../core/utils/failure_handler.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc() : super(NotificationLoadingState()) {
    on<NotificationInitEvent>(_onNotificationInitEvent);
    on<NotificationRefreshEvent>(_onNotificationRefreshEvent);
    _notificationListener();
  }

  final _logger = Logger();
  final _notificationService = locator<INotificationService>();

  FutureOr<void> _onNotificationInitEvent(
    NotificationInitEvent event,
    Emitter<NotificationState> emit,
  ) async {
    try {
      final res = await FetchNotifications().call(NoParams());
      emit(NotificationIdleState(notificationData: res));
      if (!event.readNotifications) return;
      await Future.delayed(const Duration(seconds: 2));
      final updatedRes = await ReadAllNotifications().call(NoParams());
      emit(NotificationIdleState(
        notificationData: updatedRes,
        showBadge: false,
      ));
      _notificationService.clearNotificationStream();
    } on Failure catch (e, s) {
      _logger.e(e);
      FailureHandler.instance.catchError(e, stackTrace: s);
      emit(NotificationFailureState(e));
    }
  }

  FutureOr<void> _onNotificationRefreshEvent(
    NotificationRefreshEvent event,
    Emitter<NotificationState> emit,
  ) async {
    try {
      final res = await FetchNotifications().call(NoParams());
      emit(NotificationIdleState(notificationData: res));
      await Future.delayed(const Duration(seconds: 2));
      final updatedRes = await ReadAllNotifications().call(NoParams());
      emit(NotificationIdleState(notificationData: updatedRes));
    } on Failure catch (e, s) {
      _logger.e(e);
      FailureHandler.instance.catchError(e, stackTrace: s);
      emit(NotificationFailureState(e));
    }
  }

  void _notificationListener() {
    notificationStream.listen((event) {
      if (state is! NotificationIdleState) return;
      if (isClosed) return;
      // ignore: invalid_use_of_visible_for_testing_member
      emit((state as NotificationIdleState).copyWith(showBadge: event != null));
    });
  }

  Stream<NotificationData?> get notificationStream =>
      _notificationService.notificationStream;
}
