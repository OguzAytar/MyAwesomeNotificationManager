import 'dart:developer';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:ogzawesomenotificationmanager/src/core/base/base_notification_handler.dart';
import 'package:ogzawesomenotificationmanager/src/data/models/received_action_model.dart';
import 'package:ogzawesomenotificationmanager/src/data/models/received_notification_model.dart';
import 'package:ogzawesomenotificationmanager/src/presentation/services/notification_service.dart';

/// Notification Controller for handling notification events
class NotificationController {
  /// Handle notification action (when user taps on notification)
  @pragma('vm:entry-point')
  static Future<void> onActionReceivedMethod(ReceivedAction action) async {
    final handler = NotificationService.getHandler[action.channelKey];
    try {
      if (handler != null) {
        await handler.onActionReceived(ReceivedActionModel(action));
        log('Notification clicked: ${action.title}');
      } else {
        log('Handler not found for channel: ${action.channelKey}');
      }
    } catch (e, stackTrace) {
      log('Error in onActionReceivedMethod: $e');
      log('Error details: $stackTrace');
    }
  }

  /// Handle notification creation
  @pragma('vm:entry-point')
  static Future<void> onNotificationCreatedMethod(ReceivedNotification notification) async {
    final handler = _getHandler(notification: ReceivedNotificationModel(notification));
    await handler?.onNotificationCreated(ReceivedNotificationModel(notification));
  }

  /// Handle notification display
  @pragma('vm:entry-point')
  static Future<void> onNotificationDisplayedMethod(ReceivedNotification notification) async {
    final handler = _getHandler(notification: ReceivedNotificationModel(notification));
    await handler?.onNotificationDisplayed(ReceivedNotificationModel(notification));
    log('Notification displayed: ${notification.title}');
  }

  /// Handle notification dismiss
  @pragma('vm:entry-point')
  static Future<void> onDismissActionReceivedMethod(ReceivedAction action) async {
    final handler = _getHandler(action: ReceivedActionModel(action));
    await handler?.onDismissActionReceived(ReceivedActionModel(action));
    log('Notification dismissed: ${action.title}');
  }

  /// Get handler for notification based on channel key
  static BaseNotificationHandler? _getHandler({ReceivedActionModel? action, ReceivedNotificationModel? notification}) =>
      NotificationService.getHandler[notification?.channelKey ?? action?.channelKey];
}
