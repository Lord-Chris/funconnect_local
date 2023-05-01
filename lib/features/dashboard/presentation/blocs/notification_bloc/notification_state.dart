import 'package:equatable/equatable.dart';
import 'package:funconnect/core/models/_models.dart';
import 'package:funconnect/features/dashboard/domain/entities/notification_model.dart';

abstract class NotificationState extends Equatable {
  List<NotificationModel> get notifications => [];

  List<NotificationModel> get unreadNotifications => [];

  @override
  List<Object?> get props => [notifications];
}

class NotificationLoadingState extends NotificationState {}

class NotificationIdleState extends NotificationState {
  final PaginatedData<NotificationModel>? notificationData;

  NotificationIdleState({
    this.notificationData,
  });

  @override
  List<NotificationModel> get notifications => notificationData?.data ?? [];

  @override
  List<NotificationModel> get unreadNotifications {
    List<NotificationModel> unread = [];
    for (var element in notificationData?.data ?? []) {
      if (element.readAt == null) {
        unread.add(element);
      }
    }
    return unread;
  }

  @override
  List<Object?> get props => [notifications, DateTime.now()];
}

class NotificationFailureState extends NotificationState with EquatableMixin {
  final Failure failure;

  NotificationFailureState(this.failure);

  @override
  List<Object> get props => [failure];
}
