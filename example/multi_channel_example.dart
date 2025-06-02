import 'package:flutter/material.dart';
import 'package:ogzawesomenotificationmanager/ogzawesomenotificationmanager.dart';

import 'handlers/marketing_notification_handler.dart';

// Global navigator key for navigation from notification handlers
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

/// Example notification handler implementation
class ExampleNotificationHandler extends BaseNotificationHandler {
  @override
  Future<void> onActionReceived(ReceivedActionModel action) async {
    debugPrint('Notification action received: ${action.title}');

    if (action.payload != null) {
      final screen = action.payload!['screen'];
      if (screen == 'profile') {
        navigatorKey.currentState?.pushNamed('/profile');
      } else if (screen == 'settings') {
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

/// Enhanced example with multiple notification channels
class MultiChannelNotificationExample {
  static final NotificationHelper _helper = NotificationHelper();

  /// Initialize the notification system with multiple channels
  static Future<void> initialize() async {
    // Define multiple channels for different purposes
    final channels = [
      // Genel bildirimler
      NotificationChannelModel(
        channelGroupKey: 'general_group',
        channelKey: 'general_channel',
        channelName: 'Genel Bildirimler',
        channelDescription: 'Genel uygulama bildirimleri',
        defaultColor: Colors.blue,
        importance: NotificationImportanceModel.high,
        playSound: true,
        enableVibration: true,
      ),

      // Marketing/Kampanya bildirimleri
      NotificationChannelModel(
        channelGroupKey: 'marketing_group',
        channelKey: 'marketing_channel',
        channelName: 'Kampanya Bildirimleri',
        channelDescription: 'Özel kampanya ve promosyon bildirimleri',
        defaultColor: Colors.orange,
        importance: NotificationImportanceModel.high,
        playSound: true,
        enableVibration: true,
        soundSource: 'resource://raw/marketing_sound', // Özel ses
      ),

      // Sistem bildirimleri
      NotificationChannelModel(
        channelGroupKey: 'system_group',
        channelKey: 'system_channel',
        channelName: 'Sistem Bildirimleri',
        channelDescription: 'Sistem güncellemeleri ve uyarıları',
        defaultColor: Colors.red,
        importance: NotificationImportanceModel.max,
        playSound: true,
        enableVibration: true,
      ),

      // Sessiz bildirimler
      NotificationChannelModel(
        channelGroupKey: 'silent_group',
        channelKey: 'silent_channel',
        channelName: 'Sessiz Bildirimler',
        channelDescription: 'Sessiz arka plan bildirimleri',
        defaultColor: Colors.grey,
        importance: NotificationImportanceModel.low,
        playSound: false,
        enableVibration: false,
      ),
    ];

    // Define channel groups
    final channelGroups = [
      NotificationChannelGroupModel(
        channelGroupKey: 'general_group',
        channelGroupName: 'Genel',
      ),
      NotificationChannelGroupModel(
        channelGroupKey: 'marketing_group',
        channelGroupName: 'Kampanyalar',
      ),
      NotificationChannelGroupModel(
        channelGroupKey: 'system_group',
        channelGroupName: 'Sistem',
      ),
      NotificationChannelGroupModel(
        channelGroupKey: 'silent_group',
        channelGroupName: 'Arka Plan',
      ),
    ];

    // Define handlers for each channel
    final handlers = {
      'general_channel': ExampleNotificationHandler(),
      'marketing_channel': MarketingNotificationHandler(),
      'system_channel': SystemNotificationHandler(),
      'silent_channel': SilentNotificationHandler(),
    };

    // Initialize notification service
    await NotificationService.initializeNotifications(
      handlers,
      channels: channels,
      channelGroups: channelGroups,
      debug: true,
    );

    await NotificationService.setListeners();
    await NotificationService.requestPermissions();
    await NotificationService.handleInitialNotificationAction();
  }

  /// Marketing kanalında bildirim gönder
  static Future<void> sendMarketingNotification({
    required int id,
    required String title,
    required String body,
    String? campaignId,
    String? productId,
  }) async {
    await _helper.createNotification(
      id: id,
      title: title,
      body: body,
      channelKey: 'marketing_channel',
      payload: {
        'type': 'marketing',
        'campaign_id': campaignId,
        'product_id': productId,
        'timestamp': DateTime.now().toIso8601String(),
      },
    );
  }

  /// Sistem kanalında bildirim gönder
  static Future<void> sendSystemNotification({
    required int id,
    required String title,
    required String body,
    String? updateType,
  }) async {
    await _helper.createNotification(
      id: id,
      title: title,
      body: body,
      channelKey: 'system_channel',
      payload: {
        'type': 'system',
        'update_type': updateType,
        'timestamp': DateTime.now().toIso8601String(),
      },
    );
  }

  /// Sessiz kanalda bildirim gönder
  static Future<void> sendSilentNotification({
    required int id,
    required String title,
    required String body,
    Map<String, String?>? customPayload,
  }) async {
    await _helper.createNotification(
      id: id,
      title: title,
      body: body,
      channelKey: 'silent_channel',
      payload: {
        'type': 'silent',
        'timestamp': DateTime.now().toIso8601String(),
        ...?customPayload,
      },
    );
  }

  /// Dinamik olarak yeni kanal ekle
  static Future<void> addNewChannel({
    required String channelKey,
    required String channelName,
    required String channelDescription,
    required BaseNotificationHandler handler,
    String? channelGroupKey,
    Color? defaultColor,
    NotificationImportanceModel? importance,
  }) async {
    // Not: Kanallar initialization sırasında eklenmeli
    // Bu metod sadece runtime'da yeni handler eklemek için kullanılabilir

    // Handler'ı ekle
    NotificationService.addHandler(channelKey, handler);

    debugPrint('New handler added for channel: $channelKey');
  }
}

// Ek handler sınıfları
class SystemNotificationHandler extends BaseNotificationHandler {
  @override
  Future<void> onActionReceived(ReceivedActionModel action) async {
    debugPrint('System notification tapped: ${action.title}');
    // Sistem bildirimlerine özel işlemler
    if (action.payload?['update_type'] == 'security') {
      navigatorKey.currentState?.pushNamed('/security-settings');
    }
  }

  @override
  Future<void> onNotificationCreated(ReceivedNotificationModel notification) async {
    debugPrint('System notification created: ${notification.title}');
  }

  @override
  Future<void> onNotificationDisplayed(ReceivedNotificationModel notification) async {
    debugPrint('System notification displayed: ${notification.title}');
  }

  @override
  Future<void> onDismissActionReceived(ReceivedActionModel action) async {
    debugPrint('System notification dismissed: ${action.title}');
  }
}

class SilentNotificationHandler extends BaseNotificationHandler {
  @override
  Future<void> onActionReceived(ReceivedActionModel action) async {
    debugPrint('Silent notification tapped: ${action.title}');
    // Sessiz bildirimlere özel işlemler
  }

  @override
  Future<void> onNotificationCreated(ReceivedNotificationModel notification) async {
    debugPrint('Silent notification created: ${notification.title}');
    // Arka plan işlemleri
  }

  @override
  Future<void> onNotificationDisplayed(ReceivedNotificationModel notification) async {
    debugPrint('Silent notification displayed: ${notification.title}');
  }

  @override
  Future<void> onDismissActionReceived(ReceivedActionModel action) async {
    debugPrint('Silent notification dismissed: ${action.title}');
  }
}
