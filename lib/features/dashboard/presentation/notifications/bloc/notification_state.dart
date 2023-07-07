import 'package:equatable/equatable.dart';
import 'package:funconnect/core/models/_models.dart';
import 'package:funconnect/features/dashboard/domain/entities/notification_model.dart';

abstract class NotificationState extends Equatable {
  List<NotificationModel> get notifications => [];

  List<NotificationModel> get unreadNotifications => [];

  bool get showNotificationBadge => false;

  @override
  List<Object?> get props => [
        notifications,
        unreadNotifications,
        showNotificationBadge,
      ];
}

class NotificationLoadingState extends NotificationState {}

class NotificationIdleState extends NotificationState {
  final PaginatedData<NotificationModel>? notificationData;
  final bool showBadge;

  NotificationIdleState({
    this.notificationData,
    this.showBadge = false,
  });

  @override
  List<NotificationModel> get notifications => notificationData?.data ?? [];

  @override
  List<NotificationModel> get unreadNotifications {
    List<NotificationModel> unread = [];
    for (var element in notifications) {
      if (element.readAt == null) {
        unread.add(element);
      }
    }
    return unread;
  }

  @override
  bool get showNotificationBadge => showBadge || unreadNotifications.isNotEmpty;

  NotificationIdleState copyWith({
    PaginatedData<NotificationModel>? notificationData,
    bool? showBadge,
  }) {
    return NotificationIdleState(
      notificationData: notificationData ?? this.notificationData,
      showBadge: showBadge ?? this.showBadge,
    );
  }

  @override
  List<Object?> get props => [
        notifications,
        unreadNotifications,
        showBadge,
        DateTime.now(),
      ];
}

class NotificationFailureState extends NotificationState with EquatableMixin {
  final Failure failure;

  NotificationFailureState(this.failure);

  @override
  List<Object> get props => [failure];
}
