import 'dart:async';

import 'package:funconnect/core/constants/_constants.dart';
import 'package:funconnect/features/dashboard/domain/entities/notification_model.dart';
import 'package:funconnect/services/notification_service/i_notification_service.dart';
import 'package:logger/logger.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import '../../core/models/_models.dart';

class NotificationService extends INotificationService {
  final _logger = Logger();
  final _controller = StreamController<NotificationData?>.broadcast();
  @override
  void init() {
    //Remove this method to stop OneSignal Debugging
    OneSignal.Debug.setLogLevel(OSLogLevel.verbose);

    OneSignal.initialize(AppKeys.oneSignalAppId);

    // The promptForPushNotificationsWithUserResponse function will show the iOS or Android push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
    OneSignal.Notifications.requestPermission(true).then((accepted) {
      _logger.i("Notification permission accepted: $accepted");
    });

    _setObservers();
  }

  void _setObservers() {
    OneSignal.Notifications.addForegroundWillDisplayListener((event) {
      // Will be called whenever a notification is received in foreground
      // Display Notification, pass null param for not displaying the notification

      /// preventDefault to not display the notification
      event.preventDefault();

      if (event.notification.body != null) {
        _controller.add(
          NotificationData(
            remoteNotificationId: event.notification.notificationId,
            title: event.notification.title ?? 'Funconnect',
            message: event.notification.body ?? '',
          ),
        );
      }

      event.complete(event.notification);
    });

    OneSignal.shared
        .setNotificationOpenedHandler((OSNotificationOpenedResult result) {
      // Will be called whenever a notification is opened/button pressed.
    });

    OneSignal.User.pushSubscription.addObserver((state) {
      _logger.i(state.current.jsonRepresentation());
    });

    OneSignal.Notifications.addPermissionObserver((state) {
      _logger.i("Has permission $state");
    });

    OneSignal.Notifications.addClickListener((event) {
      _logger.i('NOTIFICATION CLICK LISTENER CALLED WITH EVENT: $event');
    });
  }

  @override
  Future<void> setUser(UserModel user) async {
    try {
      OneSignal.login(user.id);
      OneSignal.User.addEmail(user.email);
    } catch (e) {
      _logger.e(e);
    }
  }

  @override
  Future<void> clearUser() async {
    try {
      OneSignal.logout();
    } catch (e) {
      _logger.e(e);
    }
  }

  @override
  void clearNotificationStream() {
    _controller.add(null);
  }

  @override
  Stream<NotificationData?> get notificationStream => _controller.stream;
}
