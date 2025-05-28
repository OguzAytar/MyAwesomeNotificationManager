import '../../data/models/notification_schedule_model.dart';

/// Notification Service Helper Interface
abstract class INotificationServiceHelper {
  /// Create a notification
  Future<void> createNotification({required int id, required String title, required String body, Map<String, String?>? payload, String? channelKey});

  /// Create a scheduled notification
  Future<void> createScheduledNotification({
    required int id,
    required String title,
    required String body,
    required NotificationScheduleModel schedule,
    Map<String, String?>? payload,
    String? channelKey,
  });

  /// Cancel notification by id
  Future<void> cancelNotification(int id);

  /// Cancel all notifications
  Future<void> cancelAllNotifications();

  /// Update notification
  Future<void> updateNotification({required int id, required String title, required String body, Map<String, String?>? payload, String? channelKey});
}
