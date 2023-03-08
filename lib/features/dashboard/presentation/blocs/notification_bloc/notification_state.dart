import 'package:equatable/equatable.dart';
import 'package:funconnect/core/models/_models.dart';
import 'package:funconnect/features/dashboard/domain/entities/notification_model.dart';

abstract class NotificationState extends Equatable {
  List<NotificationModel> get notifications => [];

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
  List<Object?> get props => [notifications, DateTime.now()];
}
