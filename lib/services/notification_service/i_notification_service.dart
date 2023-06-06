import 'package:funconnect/features/dashboard/domain/entities/notification_model.dart';

import '../../core/models/_models.dart';

abstract class INotificationService {
  void init();
  Future<void> setUser(UserModel user);
  Future<void> clearUser();

  void clearNotificationStream();
  Stream<NotificationData?> get notificationStream;
}
