import 'dart:developer';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:ogzawesomenotificationmanager/src/core/base/base_notification_handler.dart';
import 'package:ogzawesomenotificationmanager/src/presentation/controllers/notification_controller.dart';

/// Main Notification Service class
class NotificationService {
  static final Map<String, BaseNotificationHandler> _handlers = {};

  /// Handler getter
  static Map<String, BaseNotificationHandler> get getHandler => _handlers;

  /// Initialize notifications with custom handlers, channels and channel groups
  static Future<void> initializeNotifications(
    Map<String, BaseNotificationHandler> handlers, {
    List<NotificationChannelGroup> channelGroups = const [],
    List<NotificationChannel> channels = const [],
    String? defaultIcon,
    bool debug = false,
  }) async {
    log('Initializing notifications...');

    // Add handlers
    _handlers.addAll(handlers);

    // Default channels if none provided
    final defaultChannels = channels.isEmpty
        ? [
            NotificationChannel(
              channelGroupKey: 'default_notification_group',
              channelKey: 'default_notification',
              channelName: 'Default Notifications',
              channelDescription: 'Default notification channel',
              defaultColor: Colors.blue,
              enableLights: true,
              enableVibration: true,
              importance: NotificationImportance.High,
              playSound: true,
            ),
          ]
        : channels;

    // Default channel groups if none provided
    final defaultChannelGroups = channelGroups.isEmpty
        ? [NotificationChannelGroup(channelGroupKey: 'default_notification_group', channelGroupName: 'Default Notifications')]
        : channelGroups;

    await AwesomeNotifications().initialize(
      defaultIcon ?? 'resource://drawable/ic_launcher',
      defaultChannels,
      channelGroups: defaultChannelGroups,
      debug: debug,
    );

    log('Notifications initialized successfully');
  }

  /// Handle initial notification action when app is opened from notification
  @pragma('vm:entry-point')
  static Future<void> handleInitialNotificationAction() async {
    final initialAction = await AwesomeNotifications().getInitialNotificationAction(removeFromActionEvents: true);
    if (initialAction != null) {
      log('Initial notification action: ${initialAction.toString()}');
      await NotificationController.onActionReceivedMethod(initialAction);
    }
  }

  /// Set notification listeners
  static Future<bool> setListeners() {
    return AwesomeNotifications().setListeners(
      onActionReceivedMethod: NotificationController.onActionReceivedMethod,
      onNotificationCreatedMethod: NotificationController.onNotificationCreatedMethod,
      onNotificationDisplayedMethod: NotificationController.onNotificationDisplayedMethod,
      onDismissActionReceivedMethod: NotificationController.onDismissActionReceivedMethod,
    );
  }

  /// Request notification permissions
  static Future<bool> requestPermissions() async {
    return await AwesomeNotifications().requestPermissionToSendNotifications();
  }

  /// Check if notifications are allowed
  static Future<bool> isNotificationAllowed() async {
    return await AwesomeNotifications().isNotificationAllowed();
  }

  /// Add a new handler for a specific channel
  static void addHandler(String channelKey, BaseNotificationHandler handler) {
    _handlers[channelKey] = handler;
  }

  /// Remove handler for a specific channel
  static void removeHandler(String channelKey) {
    _handlers.remove(channelKey);
  }

  /// Clear all handlers
  static void clearHandlers() {
    _handlers.clear();
  }
}
