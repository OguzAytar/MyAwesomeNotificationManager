import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:ogzawesomenotificationmanager/src/core/interfaces/i_notification_service_helper.dart';

import '../models/notification_schedule_model.dart';
import 'notification_schedule_converter.dart';

/// Notification Helper implementation
class NotificationHelper implements INotificationServiceHelper {
  static const String _defaultChannelKey = 'default_notification';

  @override
  Future<void> createNotification({
    required int id,
    required String title,
    required String body,
    Map<String, String?>? payload,
    String? channelKey,
  }) async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(id: id, channelKey: channelKey ?? _defaultChannelKey, title: title, body: body, payload: payload),
    );
  }

  @override
  Future<void> createScheduledNotification({
    required int id,
    required String title,
    required String body,
    required NotificationScheduleModel schedule,
    Map<String, String?>? payload,
    String? channelKey,
  }) async {
    // Convert our schedule model to AwesomeNotifications schedule
    final awesomeSchedule = NotificationScheduleConverter.convertToAwesome(schedule);

    await AwesomeNotifications().createNotification(
      content: NotificationContent(id: id, channelKey: channelKey ?? _defaultChannelKey, title: title, body: body, payload: payload),
      schedule: awesomeSchedule,
    );
  }

  @override
  Future<void> cancelNotification(int id) async {
    await AwesomeNotifications().cancel(id);
  }

  @override
  Future<void> cancelAllNotifications() async {
    await AwesomeNotifications().cancelAll();
  }

  @override
  Future<void> updateNotification({
    required int id,
    required String title,
    required String body,
    Map<String, String?>? payload,
    String? channelKey,
  }) async {
    // Cancel existing notification and create new one with same ID
    await cancelNotification(id);
    await createNotification(id: id, title: title, body: body, payload: payload, channelKey: channelKey);
  }

  /// Create notification with action buttons
  Future<void> createNotificationWithActions({
    required int id,
    required String title,
    required String body,
    required List<NotificationActionButton> actionButtons,
    Map<String, String?>? payload,
    String? channelKey,
  }) async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(id: id, channelKey: channelKey ?? _defaultChannelKey, title: title, body: body, payload: payload),
      actionButtons: actionButtons,
    );
  }

  /// Create notification with big picture
  Future<void> createBigPictureNotification({
    required int id,
    required String title,
    required String body,
    required String bigPicture,
    Map<String, String?>? payload,
    String? channelKey,
  }) async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: id,
        channelKey: channelKey ?? _defaultChannelKey,
        title: title,
        body: body,
        bigPicture: bigPicture,
        notificationLayout: NotificationLayout.BigPicture,
        payload: payload,
      ),
    );
  }

  /// Get list of scheduled notifications
  Future<List<NotificationModel>> getScheduledNotifications() async {
    return await AwesomeNotifications().listScheduledNotifications();
  }

  /// Check if notification with id exists
  Future<bool> isNotificationActive(int id) async {
    final activeNotifications = await AwesomeNotifications().listScheduledNotifications();
    return activeNotifications.any((notification) => notification.content?.id == id);
  }
}
