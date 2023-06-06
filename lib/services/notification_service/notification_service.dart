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
    OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

    OneSignal.shared.setAppId(AppKeys.oneSignalAppId);

    // The promptForPushNotificationsWithUserResponse function will show the iOS or Android push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
    OneSignal.shared
        .promptUserForPushNotificationPermission(fallbackToSettings: true)
        .then((accepted) {
      _logger.i("Notification permission accepted: $accepted");
    });

    _setObservers();
  }

  void _setObservers() {
    OneSignal.shared.setNotificationWillShowInForegroundHandler(
        (OSNotificationReceivedEvent event) {
      // Will be called whenever a notification is received in foreground
      // Display Notification, pass null param for not displaying the notification
      if (event.notification.body != null) {
        _controller.add(
          NotificationData(
            remoteNotificationId: event.notification.notificationId,
            title: event.notification.title ?? 'Funconnect',
            message: event.notification.body ?? '',
          ),
        );
      }
      _logger.d("Notification Entered", event.notification.body);
      event.complete(event.notification);
    });

    OneSignal.shared
        .setNotificationOpenedHandler((OSNotificationOpenedResult result) {
      // Will be called whenever a notification is opened/button pressed.
    });

    OneSignal.shared.setPermissionObserver((OSPermissionStateChanges changes) {
      // Will be called whenever the permission changes
      // (ie. user taps Allow on the permission prompt in iOS)
    });

    OneSignal.shared
        .setSubscriptionObserver((OSSubscriptionStateChanges changes) {
      // Will be called whenever the subscription changes
      // (ie. user gets registered with OneSignal and gets a user ID)
    });

    OneSignal.shared.setEmailSubscriptionObserver(
        (OSEmailSubscriptionStateChanges emailChanges) {
      // Will be called whenever then user's email subscription changes
      // (ie. OneSignal.setEmail(email) is called and the user gets registered
    });
  }

  @override
  Future<void> setUser(UserModel user) async {
    try {
      await OneSignal.shared.setExternalUserId(user.id);
      await OneSignal.shared.setEmail(email: user.email);
    } catch (e) {
      _logger.e(e);
    }
  }

  @override
  Future<void> clearUser() async {
    try {
      await OneSignal.shared.removeExternalUserId();
      await OneSignal.shared.logoutEmail();
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
