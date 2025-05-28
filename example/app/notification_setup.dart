import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:ogzawesomenotificationmanager/ogzawesomenotificationmanager.dart';

import 'main.dart' as main;

/// Bildirim kurulum sınıfı
class NotificationSetup {
  /// Tüm bildirimleri başlat
  static Future<void> initialize() async {
    // Kanalları tanımla
    final channels = [
      // Genel kanal
      NotificationChannel(
        channelGroupKey: 'general_group',
        channelKey: 'example_channel',
        channelName: '📱 Genel Bildirimler',
        channelDescription: 'Genel uygulama bildirimleri',
        defaultColor: Colors.blue,
        importance: NotificationImportance.High,
        playSound: true,
        enableVibration: true,
        enableLights: true,
      ),

      // Marketing kanalı
      NotificationChannel(
        channelGroupKey: 'marketing_group',
        channelKey: 'marketing_channel',
        channelName: '🎯 Kampanya Bildirimleri',
        channelDescription: 'Özel kampanya ve promosyon bildirimleri',
        defaultColor: Colors.purple,
        importance: NotificationImportance.High,
        playSound: true,
        enableVibration: true,
        enableLights: true,
      ),

      // Sistem kanalı
      NotificationChannel(
        channelGroupKey: 'system_group',
        channelKey: 'system_channel',
        channelName: '🔒 Sistem Bildirimleri',
        channelDescription: 'Sistem güncellemeleri ve uyarıları',
        defaultColor: Colors.red,
        importance: NotificationImportance.Max,
        playSound: true,
        enableVibration: true,
        enableLights: true,
      ),

      // Sessiz kanal
      NotificationChannel(
        channelGroupKey: 'background_group',
        channelKey: 'silent_channel',
        channelName: '🔇 Arka Plan Bildirimleri',
        channelDescription: 'Sessiz arka plan bildirimleri',
        defaultColor: Colors.grey,
        importance: NotificationImportance.Low,
        playSound: false,
        enableVibration: false,
        enableLights: false,
      ),
    ];

    // Kanal gruplarını tanımla
    final channelGroups = [
      NotificationChannelGroup(
        channelGroupKey: 'general_group',
        channelGroupName: '📱 Genel',
      ),
      NotificationChannelGroup(
        channelGroupKey: 'marketing_group',
        channelGroupName: '🎯 Kampanyalar',
      ),
      NotificationChannelGroup(
        channelGroupKey: 'system_group',
        channelGroupName: '🔒 Sistem',
      ),
      NotificationChannelGroup(
        channelGroupKey: 'background_group',
        channelGroupName: '🔇 Arka Plan',
      ),
    ];

    // Handler'ları tanımla
    final handlers = {
      'example_channel': GeneralNotificationHandler(),
      'marketing_channel': MarketingNotificationHandler(),
      'system_channel': SystemNotificationHandler(),
      'silent_channel': SilentNotificationHandler(),
    };

    try {
      // Notification Service'i başlat
      await NotificationService.initializeNotifications(
        handlers,
        channels: channels,
        channelGroups: channelGroups,
        debug: true,
      );

      // Listener'ları ayarla
      await NotificationService.setListeners();

      // İzinleri iste
      await NotificationService.requestPermissions();

      // İlk bildirim aksiyonunu kontrol et
      await NotificationService.handleInitialNotificationAction();

      debugPrint('✅ Bildirimler başarıyla başlatıldı!');
    } catch (e) {
      debugPrint('❌ Bildirim başlatma hatası: $e');
    }
  }
}

/// Genel bildirim handler'ı
class GeneralNotificationHandler extends BaseNotificationHandler {
  @override
  Future<void> onActionReceived(ReceivedActionModel action) async {
    debugPrint('🔔 Genel bildirim tıklandı: ${action.title}');

    // Payload'a göre navigasyon
    if (action.payload != null) {
      final screen = action.payload!['screen'];
      final type = action.payload!['type'];

      if (screen == 'profile') {
        main.navigatorKey.currentState?.pushNamed('/profile');
      } else if (screen == 'settings') {
        main.navigatorKey.currentState?.pushNamed('/settings');
      } else if (type == 'action') {
        _handleActionButton(action);
      }
    }
  }

  void _handleActionButton(ReceivedActionModel action) {
    final buttonKey = action.buttonKeyPressed;
    if (buttonKey == 'accept') {
      debugPrint('✅ Kullanıcı kabul etti');
      // Kabul işlemi
    } else if (buttonKey == 'decline') {
      debugPrint('❌ Kullanıcı reddetti');
      // Reddetme işlemi
    }
  }

  @override
  Future<void> onNotificationCreated(ReceivedNotificationModel notification) async {
    debugPrint('📝 Genel bildirim oluşturuldu: ${notification.title}');
  }

  @override
  Future<void> onNotificationDisplayed(ReceivedNotificationModel notification) async {
    debugPrint('👁️ Genel bildirim gösterildi: ${notification.title}');
  }

  @override
  Future<void> onDismissActionReceived(ReceivedActionModel action) async {
    debugPrint('🗑️ Genel bildirim kapatıldı: ${action.title}');
  }
}

/// Marketing bildirim handler'ı
class MarketingNotificationHandler extends BaseNotificationHandler {
  @override
  Future<void> onActionReceived(ReceivedActionModel action) async {
    debugPrint('🎯 Marketing bildirim tıklandı: ${action.title}');

    if (action.payload != null) {
      final campaignId = action.payload!['campaign_id'];
      final screen = action.payload!['screen'];

      if (screen == 'marketing') {
        main.navigatorKey.currentState?.pushNamed('/marketing', arguments: {
          'campaign_id': campaignId,
          'discount': action.payload!['discount'],
        });
      }
    }

    // Marketing analytics
    await _trackMarketingClick(action);
  }

  Future<void> _trackMarketingClick(ReceivedActionModel action) async {
    debugPrint('📊 Marketing click tracked: ${action.payload}');
    // Analytics kodu buraya
  }

  @override
  Future<void> onNotificationCreated(ReceivedNotificationModel notification) async {
    debugPrint('📝 Marketing bildirim oluşturuldu: ${notification.title}');
  }

  @override
  Future<void> onNotificationDisplayed(ReceivedNotificationModel notification) async {
    debugPrint('👁️ Marketing bildirim gösterildi: ${notification.title}');
    await _trackMarketingImpression(notification);
  }

  Future<void> _trackMarketingImpression(ReceivedNotificationModel notification) async {
    debugPrint('📈 Marketing impression tracked: ${notification.title}');
    // Impression tracking kodu
  }

  @override
  Future<void> onDismissActionReceived(ReceivedActionModel action) async {
    debugPrint('🗑️ Marketing bildirim kapatıldı: ${action.title}');
  }
}

/// Sistem bildirim handler'ı
class SystemNotificationHandler extends BaseNotificationHandler {
  @override
  Future<void> onActionReceived(ReceivedActionModel action) async {
    debugPrint('🔒 Sistem bildirim tıklandı: ${action.title}');

    if (action.payload != null) {
      final updateType = action.payload!['update_type'];
      final screen = action.payload!['screen'];

      if (screen == 'system') {
        main.navigatorKey.currentState?.pushNamed('/system', arguments: {
          'update_type': updateType,
        });
      }
    }
  }

  @override
  Future<void> onNotificationCreated(ReceivedNotificationModel notification) async {
    debugPrint('📝 Sistem bildirim oluşturuldu: ${notification.title}');
  }

  @override
  Future<void> onNotificationDisplayed(ReceivedNotificationModel notification) async {
    debugPrint('👁️ Sistem bildirim gösterildi: ${notification.title}');
  }

  @override
  Future<void> onDismissActionReceived(ReceivedActionModel action) async {
    debugPrint('🗑️ Sistem bildirim kapatıldı: ${action.title}');
  }
}

/// Sessiz bildirim handler'ı
class SilentNotificationHandler extends BaseNotificationHandler {
  @override
  Future<void> onActionReceived(ReceivedActionModel action) async {
    debugPrint('🔇 Sessiz bildirim tıklandı: ${action.title}');
    // Sessiz bildirimler genelde arka plan işlemleri için kullanılır
  }

  @override
  Future<void> onNotificationCreated(ReceivedNotificationModel notification) async {
    debugPrint('📝 Sessiz bildirim oluşturuldu: ${notification.title}');
    await _handleBackgroundTask(notification);
  }

  Future<void> _handleBackgroundTask(ReceivedNotificationModel notification) async {
    final taskType = notification.payload?['background_task'];
    if (taskType == 'sync') {
      debugPrint('🔄 Arka plan senkronizasyonu başlatıldı');
      // Senkronizasyon işlemi
    }
  }

  @override
  Future<void> onNotificationDisplayed(ReceivedNotificationModel notification) async {
    debugPrint('👁️ Sessiz bildirim gösterildi: ${notification.title}');
  }

  @override
  Future<void> onDismissActionReceived(ReceivedActionModel action) async {
    debugPrint('🗑️ Sessiz bildirim kapatıldı: ${action.title}');
  }
}
