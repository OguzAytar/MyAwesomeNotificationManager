import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:ogzawesomenotificationmanager/ogzawesomenotificationmanager.dart';

/// Global Navigator Key
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

/// Example notification handler implementation
class ExampleNotificationHandler extends BaseNotificationHandler {
  @override
  Future<void> onActionReceived(ReceivedActionModel action) async {
    // Handle notification tap action
    debugPrint('Notification action received: ${action.title}');

    // Navigate to specific screen based on payload
    if (action.payload != null) {
      final screen = action.payload!['screen'];
      if (screen == 'profile') {
        // Navigate to profile screen
        navigatorKey.currentState?.pushNamed('/profile');
      } else if (screen == 'settings') {
        // Navigate to settings screen
        navigatorKey.currentState?.pushNamed('/settings');
      }
    }
  }

  @override
  Future<void> onNotificationCreated(ReceivedNotificationModel notification) async {
    debugPrint('Notification created: ${notification.title}');
  }

  @override
  Future<void> onNotificationDisplayed(ReceivedNotificationModel notification) async {
    debugPrint('Notification displayed: ${notification.title}');
  }

  @override
  Future<void> onDismissActionReceived(ReceivedActionModel action) async {
    debugPrint('Notification dismissed: ${action.title}');
  }
}

/// Example usage of the notification manager
class NotificationManagerExample {
  static final NotificationHelper _helper = NotificationHelper();

  /// Initialize the notification system
  static Future<void> initialize() async {
    // Define custom channels
    final channels = [
      NotificationChannel(
        channelGroupKey: 'example_group',
        channelKey: 'example_channel',
        channelName: 'Example Notifications',
        channelDescription: 'Example notification channel',
        defaultColor: Colors.blue,
        importance: NotificationImportance.High,
        playSound: true,
        enableVibration: true,
      ),
      NotificationChannel(
        channelGroupKey: 'alerts_group',
        channelKey: 'alerts_channel',
        channelName: 'Alert Notifications',
        channelDescription: 'Important alert notifications',
        defaultColor: Colors.red,
        importance: NotificationImportance.Max,
        playSound: true,
        enableVibration: true,
      ),
    ];

    // Define channel groups
    final channelGroups = [
      NotificationChannelGroup(channelGroupKey: 'example_group', channelGroupName: 'Example Group'),
      NotificationChannelGroup(channelGroupKey: 'alerts_group', channelGroupName: 'Alerts Group'),
    ];

    // Define handlers for each channel
    final handlers = {'example_channel': ExampleNotificationHandler(), 'alerts_channel': ExampleNotificationHandler()};

    // Initialize notification service
    await NotificationService.initializeNotifications(handlers, channels: channels, channelGroups: channelGroups, debug: true);

    // Set listeners
    await NotificationService.setListeners();

    // Request permissions
    await NotificationService.requestPermissions();

    // Handle initial notification if app opened from notification
    await NotificationService.handleInitialNotificationAction();
  }

  /// Send a simple notification
  static Future<void> sendSimpleNotification() async {
    await _helper.createNotification(
      id: 1,
      title: 'Simple Notification',
      body: 'This is a simple notification example',
      channelKey: 'example_channel',
      payload: {'screen': 'profile', 'data': 'example_data'},
    );
  }

  /// Send a notification with action buttons
  static Future<void> sendNotificationWithActions() async {
    await _helper.createNotificationWithActions(
      id: 2,
      title: 'Action Notification',
      body: 'This notification has action buttons',
      channelKey: 'example_channel',
      actionButtons: [
        NotificationActionButton(key: 'accept', label: 'Accept', actionType: ActionType.SilentAction),
        NotificationActionButton(key: 'decline', label: 'Decline', actionType: ActionType.SilentAction),
      ],
      payload: {'type': 'action_notification'},
    );
  }

  /// Send a scheduled notification
  static Future<void> sendScheduledNotification() async {
    await _helper.createScheduledNotification(
      id: 3,
      title: 'Scheduled Notification',
      body: 'This notification was scheduled',
      channelKey: 'example_channel',
      schedule: NotificationScheduleConverter.afterMinutes(1),
      payload: {'type': 'scheduled'},
    );
  }

  /// Send a big picture notification
  static Future<void> sendBigPictureNotification() async {
    await _helper.createBigPictureNotification(
      id: 4,
      title: 'Big Picture Notification',
      body: 'This notification has a big picture',
      bigPicture: 'https://via.placeholder.com/600x300',
      channelKey: 'example_channel',
      payload: {'type': 'big_picture'},
    );
  }

  /// Cancel a specific notification
  static Future<void> cancelNotification(int id) async {
    await _helper.cancelNotification(id);
  }

  /// Cancel all notifications
  static Future<void> cancelAllNotifications() async {
    await _helper.cancelAllNotifications();
  }
}
