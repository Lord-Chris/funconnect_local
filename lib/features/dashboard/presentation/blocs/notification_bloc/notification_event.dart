import 'package:equatable/equatable.dart';

abstract class NotificationEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class NotificationInitEvent extends NotificationEvent {
  final bool readNotifications;

  NotificationInitEvent([
    this.readNotifications = true,
  ]);

  @override
  List<Object?> get props => [readNotifications];
}

class NotificationRefreshEvent extends NotificationEvent {}
