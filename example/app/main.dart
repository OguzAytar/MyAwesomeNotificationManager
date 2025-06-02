import 'package:flutter/material.dart';
import 'package:ogzawesomenotificationmanager/ogzawesomenotificationmanager.dart';

import 'notification_setup.dart';
import 'screens.dart';

// Global navigator key for navigation from notification handlers
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Bildirimleri başlat
  await NotificationSetup.initialize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notification Manager Demo',
      navigatorKey: navigatorKey, // Global navigator key
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/settings': (context) => const SettingsScreen(),
        '/marketing': (context) => const MarketingScreen(),
        '/system': (context) => const SystemScreen(),
      },
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final NotificationHelper _helper = NotificationHelper();
  int _notificationId = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification Manager Demo'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                '📱 Bildirim Manager Demo',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),

              // Basit Bildirimler
              _buildSection(
                'Basit Bildirimler',
                Icons.notifications,
                Colors.blue,
                [
                  _buildNotificationButton(
                    'Basit Bildirim Gönder',
                    () => _sendSimpleNotification(),
                    Colors.blue,
                  ),
                  _buildNotificationButton(
                    'Profil Bildirimi',
                    () => _sendProfileNotification(),
                    Colors.green,
                  ),
                  _buildNotificationButton(
                    'Ayarlar Bildirimi',
                    () => _sendSettingsNotification(),
                    Colors.orange,
                  ),
                ],
              ),

              // Özel Kanallar
              _buildSection(
                'Özel Kanallar',
                Icons.category,
                Colors.purple,
                [
                  _buildNotificationButton(
                    'Marketing Bildirimi',
                    () => _sendMarketingNotification(),
                    Colors.purple,
                  ),
                  _buildNotificationButton(
                    'Sistem Bildirimi',
                    () => _sendSystemNotification(),
                    Colors.red,
                  ),
                  _buildNotificationButton(
                    'Sessiz Bildirim',
                    () => _sendSilentNotification(),
                    Colors.grey,
                  ),
                ],
              ),

              // Gelişmiş Bildirimler
              _buildSection(
                'Gelişmiş Bildirimler',
                Icons.star,
                Colors.amber,
                [
                  _buildNotificationButton(
                    'Aksiyon Butonlu',
                    () => _sendActionNotification(),
                    Colors.amber,
                  ),
                  _buildNotificationButton(
                    'Büyük Resimli',
                    () => _sendBigPictureNotification(),
                    Colors.teal,
                  ),
                  _buildNotificationButton(
                    'Zamanlanmış (10sn)',
                    () => _sendScheduledNotification(),
                    Colors.indigo,
                  ),
                ],
              ),

              // Yönetim
              _buildSection(
                'Bildirim Yönetimi',
                Icons.settings,
                Colors.grey,
                [
                  _buildNotificationButton(
                    'Tüm Bildirimleri İptal Et',
                    () => _cancelAllNotifications(),
                    Colors.red,
                  ),
                  _buildNotificationButton(
                    'İzinleri Kontrol Et',
                    () => _checkPermissions(),
                    Colors.blue,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String title, IconData icon, Color color, List<Widget> children) {
    return Card(
      margin: const EdgeInsets.only(bottom: 20),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationButton(String text, VoidCallback onPressed, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 12),
          ),
          child: Text(text),
        ),
      ),
    );
  }

  // Bildirim gönderme metodları
  Future<void> _sendSimpleNotification() async {
    await _helper.createNotification(
      id: _notificationId++,
      title: '📱 Basit Bildirim',
      body: 'Bu basit bir bildirim örneğidir',
      channelKey: 'example_channel',
      payload: {
        'type': 'simple',
        'timestamp': DateTime.now().toIso8601String(),
      },
    );
    _showSnackBar('Basit bildirim gönderildi!');
  }

  Future<void> _sendProfileNotification() async {
    await _helper.createNotification(
      id: _notificationId++,
      title: '👤 Profil Bildirimi',
      body: 'Profilinizi güncelleyin! Tıklayın.',
      channelKey: 'example_channel',
      payload: {
        'screen': 'profile',
        'type': 'profile',
      },
    );
    _showSnackBar('Profil bildirimi gönderildi!');
  }

  Future<void> _sendSettingsNotification() async {
    await _helper.createNotification(
      id: _notificationId++,
      title: '⚙️ Ayarlar Bildirimi',
      body: 'Yeni ayarlar mevcut! Kontrol edin.',
      channelKey: 'example_channel',
      payload: {
        'screen': 'settings',
        'type': 'settings',
      },
    );
    _showSnackBar('Ayarlar bildirimi gönderildi!');
  }

  Future<void> _sendMarketingNotification() async {
    await _helper.createNotification(
      id: _notificationId++,
      title: '🎯 Özel Kampanya!',
      body: '%50 indirim! Kaçırmayın, hemen tıklayın!',
      channelKey: 'marketing_channel',
      payload: {
        'screen': 'marketing',
        'campaign_id': 'summer2025',
        'discount': '50',
      },
    );
    _showSnackBar('Marketing bildirimi gönderildi!');
  }

  Future<void> _sendSystemNotification() async {
    await _helper.createNotification(
      id: _notificationId++,
      title: '🔒 Sistem Uyarısı',
      body: 'Güvenlik güncellemesi mevcut',
      channelKey: 'system_channel',
      payload: {
        'screen': 'system',
        'update_type': 'security',
      },
    );
    _showSnackBar('Sistem bildirimi gönderildi!');
  }

  Future<void> _sendSilentNotification() async {
    await _helper.createNotification(
      id: _notificationId++,
      title: '🔇 Sessiz Bildirim',
      body: 'Bu sessiz bir bildirimdir',
      channelKey: 'silent_channel',
      payload: {
        'type': 'silent',
        'background_task': 'sync',
      },
    );
    _showSnackBar('Sessiz bildirim gönderildi!');
  }

  Future<void> _sendActionNotification() async {
    await _helper.createNotificationWithActions(
      id: _notificationId++,
      title: '🎬 Aksiyon Bildirimi',
      body: 'Bu bildirimde butonlar var!',
      channelKey: 'example_channel',
      actionButtons: [
        NotificationActionButtonModel(
          key: 'accept',
          label: '✅ Kabul Et',
          actionType: ActionTypeModel.silentAction,
        ),
        NotificationActionButtonModel(
          key: 'decline',
          label: '❌ Reddet',
          actionType: ActionTypeModel.silentAction,
        ),
      ],
      payload: {
        'type': 'action',
        'action_type': 'confirmation',
      },
    );
    _showSnackBar('Aksiyon bildirimi gönderildi!');
  }

  Future<void> _sendBigPictureNotification() async {
    await _helper.createBigPictureNotification(
      id: _notificationId++,
      title: '🖼️ Büyük Resim',
      body: 'Bu bildirimde büyük bir resim var!',
      bigPicture: 'https://picsum.photos/600/300',
      channelKey: 'example_channel',
      payload: {
        'type': 'big_picture',
        'image_url': 'https://picsum.photos/600/300',
      },
    );
    _showSnackBar('Büyük resimli bildirim gönderildi!');
  }

  Future<void> _sendScheduledNotification() async {
    // Yeni schedule model kullanarak 10 saniye sonra bildirim gönder
    final exactSchedule = NotificationScheduleConverter.createInterval(
      seconds: 10,
      preciseAlarm: true,
    );

    await _helper.createScheduledNotification(
      id: _notificationId++,
      title: '⏰ Zamanlanmış Bildirim',
      body: 'Bu bildirim 10 saniye sonra gelecek!',
      channelKey: 'example_channel',
      schedule: exactSchedule,
      payload: {
        'type': 'scheduled',
        'scheduled_time': DateTime.now().add(const Duration(seconds: 10)).toIso8601String(),
      },
    );
    _showSnackBar('Zamanlanmış bildirim 10 saniye sonra gelecek!');
  }

  Future<void> _cancelAllNotifications() async {
    await _helper.cancelAllNotifications();
    _showSnackBar('Tüm bildirimler iptal edildi!');
  }

  Future<void> _checkPermissions() async {
    final isAllowed = await NotificationService.isNotificationAllowed();
    if (isAllowed) {
      _showSnackBar('✅ Bildirim izinleri aktif');
    } else {
      _showSnackBar('❌ Bildirim izinleri kapalı');
      await NotificationService.requestPermissions();
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
