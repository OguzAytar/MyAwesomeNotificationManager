# 🔔 Ogz Awesome Notification Manager

Awesome Notifications kütüphanesi için geliştirilmiş, katmanlı mimari yapısına sahip, handler-tabanlı bir Flutter notification manager paketi.

## 🚀 Özellikler

- ✅ **Katmanlı Mimari**: Clean Architecture prensiplerine uygun yapı
- ✅ **Handler-Tabanlı Sistem**: Kanal bazında özelleştirilebilir notification handler'ları
- ✅ **Type-Safe Modeller**: Awesome Notifications modellerini saran güvenli wrapper'lar
- ✅ **Kolay Entegrasyon**: Tek satır kod ile initialization
- ✅ **Multiple Channel Desteği**: Farklı türlerde notification kanalları
- ✅ **Scheduled Notifications**: Zamanlanmış bildirim desteği
- ✅ **Action Buttons**: Bildirim aksiyonları ve butonlar
- ✅ **Big Picture Support**: Büyük resimli bildirimler
- ✅ **Navigation Integration**: Payload tabanlı otomatik navigasyon
- ✅ **Kapsamlı Örnekler**: Tam çalışan Flutter app örneği

## 📦 Kurulum

```yaml
dependencies:
  ogzawesomenotificationmanager: ^0.0.1
  awesome_notifications: ^0.9.3+1
```

```bash
flutter pub get
```

## 🔧 Hızlı Başlangıç

### 1. Notification Manager'ı Initialize Edin

```dart
import 'package:ogzawesomenotificationmanager/ogzawesomenotificationmanager.dart';

// Handler'ları tanımlayın
final handlers = {
  'general_channel': GeneralNotificationHandler(),
  'marketing_channel': MarketingNotificationHandler(),
};

// Kanalları tanımlayın
final channels = [
  NotificationChannel(
    channelKey: 'general_channel',
    channelName: '📱 Genel Bildirimler',
    channelDescription: 'Genel uygulama bildirimleri',
    defaultColor: Colors.blue,
    importance: NotificationImportance.High,
  ),
];

// Initialize edin
await NotificationService.initializeNotifications(
  handlers,
  channels: channels,
  debug: true,
);
```

### 2. Notification Handler Oluşturun

```dart
class GeneralNotificationHandler extends BaseNotificationHandler {
  @override
  Future<void> onActionReceived(ReceivedActionModel action) async {
    // Bildirim tıklandığında çalışır
    if (action.payload?['screen'] == 'profile') {
      // Profile sayfasına yönlendir
      navigatorKey.currentState?.pushNamed('/profile');
    }
  }

  @override
  Future<void> onNotificationDisplayed(ReceivedNotificationModel notification) async {
    // Bildirim gösterildiğinde çalışır
    print('Bildirim gösterildi: ${notification.title}');
  }
}
```

### 3. Bildirim Gönderin

```dart
final helper = NotificationHelper();

// Basit bildirim
await helper.createNotification(
  id: 1,
  title: '👋 Merhaba!',
  body: 'Bu bir test bildirimidir',
  channelKey: 'general_channel',
  payload: {'screen': 'profile'},
);

// Action butonlu bildirim
await helper.createNotificationWithActions(
  id: 2,
  title: '🎯 Aksiyon Gerekli',
  body: 'Seçim yapın',
  channelKey: 'general_channel',
  actionButtons: [
    NotificationActionButton(
      key: 'accept',
      label: '✅ Kabul Et',
    ),
    NotificationActionButton(
      key: 'decline',
      label: '❌ Reddet',
    ),
  ],
);

// Zamanlanmış bildirim - Yeni Schedule API
await helper.createScheduledNotification(
  id: 3,
  title: '⏰ Zamanlanmış Bildirim',
  body: 'Bu bildirim 10 saniye sonra gelecek',
  channelKey: 'general_channel',
  schedule: NotificationScheduleConverter.createInterval(seconds: 10),
  payload: {'type': 'scheduled'},
);
```

## ⏰ Zamanlanmış Bildirimler - Yeni Schedule API

Bu paket, awesome_notifications bağımlılığını gizlemek için kendi schedule modellerini kullanır:

### Basit Zaman Aralıkları

```dart
// 30 saniye sonra
final schedule1 = NotificationScheduleConverter.createInterval(seconds: 30);

// 5 dakika sonra (helper metod)
final schedule2 = NotificationScheduleConverter.afterMinutes(5);

// 2 saat sonra (helper metod)
final schedule3 = NotificationScheduleConverter.afterHours(2);

// 3 gün sonra (helper metod)
final schedule4 = NotificationScheduleConverter.afterDays(3);
```

### Belirli Tarih ve Saat

```dart
// Yarın saat 09:00'da
final tomorrow9AM = DateTime.now().add(Duration(days: 1))
    .copyWith(hour: 9, minute: 0, second: 0);

final schedule = NotificationScheduleConverter.createExactDate(
  dateTime: tomorrow9AM,
  preciseAlarm: true,
);
```

### Tekrar Eden Bildirimler

```dart
// Her gün saat 08:00'da
final dailySchedule = NotificationScheduleConverter.dailyAt(
  hour: 8, 
  minute: 0,
);

// Her Pazartesi saat 09:00'da
final weeklySchedule = NotificationScheduleConverter.weeklyAt(
  weekday: 1, // 1 = Pazartesi
  hour: 9,
  minute: 0,
);

// Her ayın 15'inde saat 12:00'da
final monthlySchedule = NotificationScheduleConverter.monthlyAt(
  day: 15,
  hour: 12,
  minute: 0,
);
```

### Gelişmiş Takvim Tabanlı

```dart
// Her Cuma saat 17:00'da
final fridaySchedule = NotificationScheduleConverter.createCalendar(
  weekday: 5, // Cuma
  hour: 17,
  minute: 0,
  repeats: true,
);

// 2025 yılının Aralık ayında
final yearEndSchedule = NotificationScheduleConverter.createCalendar(
  year: 2025,
  month: 12,
  day: 25,
  hour: 9,
  minute: 0,
);
```

### Cron Tabanlı (Sadece Android)

```dart
// Her gün saat 14:30'da
final cronSchedule = NotificationScheduleConverter.createCron(
  cronExpression: '0 30 14 * * ?',
  preciseAlarm: true,
);

// Her Pazartesi, Çarşamba, Cuma saat 08:00'da
final workdaysSchedule = NotificationScheduleConverter.createCron(
  cronExpression: '0 0 8 * * MON,WED,FRI',
  preciseAlarm: true,
);
```

### Zamanlanmış Bildirim Gönderme

```dart
final helper = NotificationHelper();

// Schedule oluştur
final schedule = NotificationScheduleConverter.afterMinutes(30);

// Bildirim gönder
await helper.createScheduledNotification(
  id: 100,
  title: '⏰ 30 Dakika Sonra',
  body: 'Bu bildirim 30 dakika gecikmeyle gönderildi',
  channelKey: 'general_channel',
  schedule: schedule,
  payload: {'type': 'delayed', 'minutes': '30'},
);
```

## 📱 Tam Örnek Uygulama

Bu paket ile birlikte kapsamlı bir örnek uygulama gelir. Çalıştırmak için:

```bash
cd example
flutter pub get
flutter run --target app/main.dart
```

Örnek uygulama şunları içerir:
- 4 farklı notification kanalı (General, Marketing, System, Silent)
- Farklı bildirim türleri (Basit, Action butonlu, Büyük resimli, Zamanlanmış)
- Navigasyon sistemi
- Handler örnekleri
- UI test ekranları

## 🏗️ Mimari

```
lib/
├── src/
│   ├── core/
│   │   ├── base/
│   │   │   └── base_notification_handler.dart    # Base handler sınıfı
│   │   └── interfaces/
│   │       └── i_notification_service_helper.dart # Service interface
│   ├── data/
│   │   ├── models/
│   │   │   ├── received_action_model.dart         # Action model wrapper
│   │   │   └── received_notification_model.dart   # Notification model wrapper
│   │   └── helpers/
│   │       └── notification_helper.dart           # CRUD operations
│   └── presentation/
│       ├── services/
│       │   └── notification_service.dart          # Ana service
│       └── controllers/
│           └── notification_controller.dart       # Event controller
└── ogzawesomenotificationmanager.dart            # Ana export
```

## 🔗 Kanal Yönetimi

### Yeni Kanal Ekleme

```dart
// 1. Kanal tanımı
final newChannel = NotificationChannel(
  channelKey: 'custom_channel',
  channelName: '🎵 Özel Kanal',
  channelDescription: 'Özel bildirimler',
  defaultColor: Colors.purple,
  importance: NotificationImportance.High,
  playSound: true,
  enableVibration: true,
);

// 2. Handler oluşturma
class CustomNotificationHandler extends BaseNotificationHandler {
  @override
  Future<void> onActionReceived(ReceivedActionModel action) async {
    // Özel işlemler
  }
}

// 3. Handler'ı ekle
final handlers = {
  'custom_channel': CustomNotificationHandler(),
};
```

## 📋 API Referansı

### NotificationHelper

```dart
// Basit bildirim oluştur
await helper.createNotification(
  id: int,
  title: String,
  body: String,
  channelKey: String,
  payload: Map<String, String>?,
);

// Action butonlu bildirim
await helper.createNotificationWithActions(
  id: int,
  title: String,
  body: String,
  channelKey: String,
  actionButtons: List<NotificationActionButton>,
  payload: Map<String, String>?,
);

// Büyük resimli bildirim
await helper.createBigPictureNotification(
  id: int,
  title: String,
  body: String,
  bigPicture: String,
  channelKey: String,
  payload: Map<String, String>?,
);

// Zamanlanmış bildirim
await helper.createScheduledNotification(
  id: int,
  title: String,
  body: String,
  channelKey: String,
  schedule: NotificationSchedule,
  payload: Map<String, String>?,
);

// Bildirim iptal et
await helper.cancelNotification(int id);

// Tüm bildirimleri iptal et
await helper.cancelAllNotifications();
```

### NotificationService

```dart
// Initialize
await NotificationService.initializeNotifications(
  Map<String, BaseNotificationHandler> handlers,
  {List<NotificationChannel>? channels,
   List<NotificationChannelGroup>? channelGroups,
   bool debug = false}
);

// İzin kontrolü
bool isAllowed = await NotificationService.isNotificationAllowed();

// İzin iste
await NotificationService.requestPermissions();

// Listener'ları ayarla
await NotificationService.setListeners();
```

## 🔍 Debug Modu

Debug modunu aktif etmek için:

```dart
await NotificationService.initializeNotifications(
  handlers,
  channels: channels,
  debug: true, // Debug logları aktif
);
```

Debug modu şunları sağlar:
- Detaylı console logları
- Handler execution tracking
- Payload debugging
- Error tracking

## 🔧 Örnek Kullanım Senaryoları

### Marketing Bildirimleri

```dart
class MarketingNotificationHandler extends BaseNotificationHandler {
  @override
  Future<void> onActionReceived(ReceivedActionModel action) async {
    final campaignId = action.payload?['campaign_id'];
    
    // Analytics tracking
    await _trackMarketingClick(campaignId);
    
    // Navigate to campaign page
    navigatorKey.currentState?.pushNamed('/marketing', 
      arguments: {'campaign_id': campaignId});
  }
  
  Future<void> _trackMarketingClick(String? campaignId) async {
    // Analytics kodu
    print('Marketing campaign clicked: $campaignId');
  }
}

// Marketing bildirimi gönder
await helper.createNotification(
  id: 100,
  title: '🎉 Özel İndirim!',
  body: '%50 indirim fırsatını kaçırma!',
  channelKey: 'marketing_channel',
  payload: {
    'screen': 'marketing',
    'campaign_id': 'summer2025',
    'discount': '50'
  },
);
```

### Sistem Bildirimleri

```dart
class SystemNotificationHandler extends BaseNotificationHandler {
  @override
  Future<void> onActionReceived(ReceivedActionModel action) async {
    final updateType = action.payload?['update_type'];
    
    if (updateType == 'security') {
      // Güvenlik güncellemesi işlemleri
      await _handleSecurityUpdate();
    }
  }
  
  Future<void> _handleSecurityUpdate() async {
    // Güvenlik güncellemesi logic
  }
}
```

### Zamanlanmış Hatırlatıcılar

```dart
// 1 saat sonra hatırlatıcı
await helper.createScheduledNotification(
  id: 200,
  title: '⏰ Hatırlatıcı',
  body: 'Toplantın 1 saat sonra başlıyor!',
  channelKey: 'general_channel',
  schedule: NotificationInterval(
    interval: 3600, // 1 saat = 3600 saniye
    timeZone: await AwesomeNotifications().getLocalTimeZoneIdentifier(),
    preciseAlarm: true,
  ),
  payload: {
    'type': 'reminder',
    'meeting_id': 'meeting_123'
  },
);
```

## 🧪 Test Etme

Paket ile birlikte gelen test uygulamasını kullanarak:

```bash
cd example
flutter run --target app/main.dart
```

Test uygulaması şu özellikleri test etmenizi sağlar:
- ✅ Farklı bildirim türleri
- ✅ Kanal bazında işlem yapma
- ✅ Action button'lar
- ✅ Payload-based navigation
- ✅ Scheduled notifications
- ✅ Permission management

## 🤝 Katkıda Bulunma

1. Fork edin
2. Feature branch oluşturun (`git checkout -b feature/amazing-feature`)
3. Commit edin (`git commit -m 'Add amazing feature'`)
4. Push edin (`git push origin feature/amazing-feature`)
5. Pull Request açın

## 📞 Destek

Herhangi bir sorun yaşarsanız:
- Issue açın: [GitHub Issues](https://github.com/yourusername/ogzawesomenotificationmanager/issues)
- Documentation: [docs/](docs/) klasörüne bakın
- Example app: [example/](example/) klasöründe tam örnekler

## 📄 Lisans

Bu proje MIT lisansı altında lisanslanmıştır. Detaylar için [LICENSE](LICENSE) dosyasına bakın.

## 🙏 Teşekkürler

- [awesome_notifications](https://pub.dev/packages/awesome_notifications) paketine teşekkürler
- Flutter topluluğuna teşekkürler

---

**Ogz Awesome Notification Manager** ile bildirimlerinizi profesyonel seviyede yönetin! 🚀
