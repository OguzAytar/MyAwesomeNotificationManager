# 📱 Yeni Bildirim Kanalı Ekleme Rehberi

Bu rehber, **ogzawesomenotificationmanager** paketine yeni bildirim kanalı ekleme işlemini adım adım açıklar.

## 🔧 Adım 1: Handler Sınıfı Oluşturun

Her kanal için özel bir handler sınıfı oluşturun:

```dart
import 'package:ogzawesomenotificationmanager/ogzawesomenotificationmanager.dart';

class MyCustomNotificationHandler extends BaseNotificationHandler {
  @override
  Future<void> onActionReceived(ReceivedActionModel action) async {
    print('Custom notification tapped: ${action.title}');
    
    // Kanala özel işlemler
    if (action.payload != null) {
      final customData = action.payload!['custom_data'];
      // İşlem yap...
    }
  }

  @override
  Future<void> onNotificationCreated(ReceivedNotificationModel notification) async {
    print('Custom notification created: ${notification.title}');
    // Analytics, logging vb.
  }

  @override
  Future<void> onNotificationDisplayed(ReceivedNotificationModel notification) async {
    print('Custom notification displayed: ${notification.title}');
    // Görüntülenme tracking
  }

  @override
  Future<void> onDismissActionReceived(ReceivedActionModel action) async {
    print('Custom notification dismissed: ${action.title}');
    // Dismiss tracking
  }
}
```

## 🔧 Adım 2: Kanal Tanımlaması

Yeni kanalınızı tanımlayın:

```dart
final newChannel = NotificationChannel(
  channelGroupKey: 'my_group',           // Kanal grubu
  channelKey: 'my_custom_channel',       // Benzersiz kanal anahtarı
  channelName: 'Özel Bildirimler',       // Kullanıcının göreceği isim
  channelDescription: 'Özel kanal açıklaması',
  defaultColor: Colors.purple,           // Kanal rengi
  importance: NotificationImportance.High,
  playSound: true,
  enableVibration: true,
  soundSource: 'resource://raw/custom_sound', // Özel ses (opsiyonel)
);
```

## 🔧 Adım 3: Başlatma Kodunu Güncelleyin

Initialization metodunuzda yeni kanalı ekleyin:

```dart
static Future<void> initialize() async {
  final channels = [
    // Mevcut kanallar...
    
    // Yeni kanalınız
    NotificationChannel(
      channelGroupKey: 'my_group',
      channelKey: 'my_custom_channel',
      channelName: 'Özel Bildirimler',
      channelDescription: 'Özel kanal açıklaması',
      defaultColor: Colors.purple,
      importance: NotificationImportance.High,
      playSound: true,
      enableVibration: true,
    ),
  ];

  final channelGroups = [
    // Mevcut gruplar...
    
    // Yeni grup (gerekirse)
    NotificationChannelGroup(
      channelGroupKey: 'my_group',
      channelGroupName: 'Özel Grup',
    ),
  ];

  final handlers = {
    // Mevcut handler'lar...
    
    // Yeni handler
    'my_custom_channel': MyCustomNotificationHandler(),
  };

  await NotificationService.initializeNotifications(
    handlers,
    channels: channels,
    channelGroups: channelGroups,
  );
}
```

## 🔧 Adım 4: Bildirim Gönderme Metodları

Yeni kanalınız için özel metodlar oluşturun:

```dart
class CustomNotificationManager {
  static final NotificationHelper _helper = NotificationHelper();

  /// Özel kanalda bildirim gönder
  static Future<void> sendCustomNotification({
    required int id,
    required String title,
    required String body,
    Map<String, String?>? customPayload,
  }) async {
    await _helper.createNotification(
      id: id,
      title: title,
      body: body,
      channelKey: 'my_custom_channel', // Yeni kanalınızın anahtarı
      payload: {
        'type': 'custom',
        'timestamp': DateTime.now().toIso8601String(),
        ...?customPayload,
      },
    );
  }

  /// Özel kanalda zamanlanmış bildirim
  static Future<void> sendScheduledCustomNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledDate,
  }) async {
    await _helper.createScheduledNotification(
      id: id,
      title: title,
      body: body,
      channelKey: 'my_custom_channel',
      schedule: NotificationCalendar.fromDate(date: scheduledDate),
      payload: {
        'type': 'custom_scheduled',
        'scheduled_for': scheduledDate.toIso8601String(),
      },
    );
  }
}
```

## 🚀 Adım 5: Dinamik Kanal Ekleme (Runtime)

Uygulama çalışırken yeni kanal eklemek için:

```dart
// Yeni kanal ekle
await MultiChannelNotificationExample.addNewChannel(
  channelKey: 'dynamic_channel',
  channelName: 'Dinamik Kanal',
  channelDescription: 'Runtime eklenen kanal',
  handler: MyCustomNotificationHandler(),
  defaultColor: Colors.green,
  importance: NotificationImportance.High,
);

// Hemen kullan
await _helper.createNotification(
  id: 999,
  title: 'Dinamik Bildirim',
  body: 'Bu dinamik olarak eklenen kanaldan geldi',
  channelKey: 'dynamic_channel',
);
```

## 📝 Kanal Türü Örnekleri

### E-ticaret Kanalları
```dart
// Sipariş bildirimleri
'order_channel' -> OrderNotificationHandler()

// Kargo bildirimleri  
'shipping_channel' -> ShippingNotificationHandler()

// Promosyon bildirimleri
'promotion_channel' -> PromotionNotificationHandler()
```

### Sosyal Medya Kanalları
```dart
// Mesaj bildirimleri
'message_channel' -> MessageNotificationHandler()

// Beğeni bildirimleri
'like_channel' -> LikeNotificationHandler()

// Takip bildirimleri
'follow_channel' -> FollowNotificationHandler()
```

### Sistem Kanalları
```dart
// Güvenlik bildirimleri
'security_channel' -> SecurityNotificationHandler()

// Güncelleme bildirimleri
'update_channel' -> UpdateNotificationHandler()

// Hata bildirimleri
'error_channel' -> ErrorNotificationHandler()
```

## ⚙️ Kanal Özelleştirme Seçenekleri

```dart
NotificationChannel(
  // Temel özellikler
  channelKey: 'unique_key',
  channelName: 'Görünen İsim',
  channelDescription: 'Açıklama',
  
  // Görsel özellikler
  defaultColor: Colors.blue,
  ledColor: Colors.white,
  
  // Ses ve titreşim
  playSound: true,
  soundSource: 'resource://raw/custom_sound',
  enableVibration: true,
  vibrationPattern: Int64List.fromList([0, 1000, 500, 1000]),
  
  // Öncelik ve davranış
  importance: NotificationImportance.High,
  defaultPrivacy: NotificationPrivacy.Public,
  enableLights: true,
  
  // Grup ayarları
  channelGroupKey: 'group_key',
  
  // Lockscreen davranışı
  criticalAlerts: false,
  defaultRingtoneType: DefaultRingtoneType.Notification,
)
```

## 🎯 İpuçları

1. **Kanal Anahtarları**: Her kanal için benzersiz anahtar kullanın
2. **Handler Sınıfları**: Her kanal türü için ayrı handler oluşturun
3. **Grup Kullanımı**: İlgili kanalları gruplara ayırın
4. **Test Etme**: Yeni kanal ekledikten sonra mutlaka test edin
5. **Performans**: Çok fazla kanal oluşturmaktan kaçının

Bu rehberi takip ederek kolayca yeni bildirim kanalları ekleyebilirsiniz! 🎉
