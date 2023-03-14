import 'package:equatable/equatable.dart';

abstract class NotificationEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class NotificationInitEvent extends NotificationEvent {}

class NotificationRefreshEvent extends NotificationEvent {}
