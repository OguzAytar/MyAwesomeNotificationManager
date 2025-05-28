
import 'package:flutter/material.dart';
import 'package:ogzawesomenotificationmanager/ogzawesomenotificationmanager.dart';

/// Zamanlanmış bildirim örnekleri - Yeni Schedule API kullanımı
class ScheduledNotificationExamples {
  static final NotificationHelper _helper = NotificationHelper();
  static int _notificationId = 1000;

  /// 1. Basit zaman aralığında bildirim (X saniye/dakika/saat sonra)
  static Future<void> sendDelayedNotifications() async {
    // 30 saniye sonra
    await _helper.createScheduledNotification(
      id: _notificationId++,
      title: '⏱️ 30 Saniye Sonra',
      body: 'Bu bildirim 30 saniye gecikmeli gönderildi',
      channelKey: 'general_channel',
      schedule: NotificationScheduleConverter.createInterval(seconds: 30),
      payload: {'type': 'delayed', 'delay': '30_seconds'},
    );

    // 5 dakika sonra
    await _helper.createScheduledNotification(
      id: _notificationId++,
      title: '⏲️ 5 Dakika Sonra',
      body: 'Bu bildirim 5 dakika gecikmeli gönderildi',
      channelKey: 'general_channel',
      schedule: NotificationScheduleConverter.afterMinutes(5),
      payload: {'type': 'delayed', 'delay': '5_minutes'},
    );

    // 2 saat sonra
    await _helper.createScheduledNotification(
      id: _notificationId++,
      title: '⏰ 2 Saat Sonra',
      body: 'Bu bildirim 2 saat gecikmeli gönderildi',
      channelKey: 'general_channel',
      schedule: NotificationScheduleConverter.afterHours(2),
      payload: {'type': 'delayed', 'delay': '2_hours'},
    );
  }

  /// 2. Belirli tarih ve saatte bildirim
  static Future<void> sendExactDateNotifications() async {
    // Yarın saat 09:00'da
    final tomorrow9AM = DateTime.now().add(const Duration(days: 1)).copyWith(
      hour: 9,
      minute: 0,
      second: 0,
      millisecond: 0,
      microsecond: 0,
    );

    await _helper.createScheduledNotification(
      id: _notificationId++,
      title: '🌅 Günaydın Hatırlatması',
      body: 'Güzel bir gün sizi bekliyor!',
      channelKey: 'general_channel',
      schedule: NotificationScheduleConverter.createExactDate(
        dateTime: tomorrow9AM,
        preciseAlarm: true,
      ),
      payload: {
        'type': 'exact_date',
        'target_date': tomorrow9AM.toIso8601String(),
      },
    );

    // Bu akşam saat 20:00'da
    final today8PM = DateTime.now().copyWith(
      hour: 20,
      minute: 0,
      second: 0,
      millisecond: 0,
      microsecond: 0,
    );

    if (today8PM.isAfter(DateTime.now())) {
      await _helper.createScheduledNotification(
        id: _notificationId++,
        title: '🌆 Akşam Hatırlatması',
        body: 'Günü değerlendirme zamanı!',
        channelKey: 'general_channel',
        schedule: NotificationScheduleConverter.createExactDate(
          dateTime: today8PM,
          preciseAlarm: true,
        ),
        payload: {
          'type': 'exact_date',
          'target_date': today8PM.toIso8601String(),
        },
      );
    }
  }

  /// 3. Tekrar eden bildirimler (günlük, haftalık, aylık)
  static Future<void> sendRepeatingNotifications() async {
    // Her gün saat 08:00'da
    await _helper.createScheduledNotification(
      id: _notificationId++,
      title: '☀️ Günlük Hatırlatma',
      body: 'Su içmeyi unutmayın!',
      channelKey: 'general_channel',
      schedule: NotificationScheduleConverter.dailyAt(hour: 8, minute: 0),
      payload: {'type': 'daily', 'task': 'drink_water'},
    );

    // Her Pazartesi saat 09:00'da (weekday: 1 = Pazartesi)
    await _helper.createScheduledNotification(
      id: _notificationId++,
      title: '📅 Haftalık Toplantı',
      body: 'Haftalık ekip toplantısına katılmayı unutmayın!',
      channelKey: 'general_channel',
      schedule: NotificationScheduleConverter.weeklyAt(
        weekday: 1, // Pazartesi
        hour: 9,
        minute: 0,
      ),
      payload: {'type': 'weekly', 'event': 'team_meeting'},
    );

    // Her ayın 1'inde saat 10:00'da
    await _helper.createScheduledNotification(
      id: _notificationId++,
      title: '📊 Aylık Rapor',
      body: 'Aylık raporunuzu hazırlama zamanı!',
      channelKey: 'general_channel',
      schedule: NotificationScheduleConverter.monthlyAt(
        day: 1,
        hour: 10,
        minute: 0,
      ),
      payload: {'type': 'monthly', 'task': 'monthly_report'},
    );
  }

  /// 4. Gelişmiş takvim tabanlı bildirimler
  static Future<void> sendAdvancedCalendarNotifications() async {
    // Her Cuma saat 17:00'da (iş bitimi hatırlatması)
    await _helper.createScheduledNotification(
      id: _notificationId++,
      title: '🎉 Hafta Sonu Yaklaşıyor!',
      body: 'İş gününüz bitmek üzere, harika bir hafta sonu geçirin!',
      channelKey: 'general_channel',
      schedule: NotificationScheduleConverter.createCalendar(
        weekday: 5, // Cuma
        hour: 17,
        minute: 0,
        repeats: true,
      ),
      payload: {'type': 'weekend_reminder', 'day': 'friday'},
    );

    // Her ayın 15'inde saat 12:00'da (maaş hatırlatması)
    await _helper.createScheduledNotification(
      id: _notificationId++,
      title: '💰 Maaş Günü Hatırlatması',
      body: 'Bugün maaş günü! Bütçenizi kontrol etmeyi unutmayın.',
      channelKey: 'general_channel',
      schedule: NotificationScheduleConverter.createCalendar(
        day: 15,
        hour: 12,
        minute: 0,
        repeats: true,
      ),
      payload: {'type': 'salary_reminder', 'day': '15th'},
    );

    // Belirli bir yılın belirli bir ayında (örnek: 2025 Aralık)
    await _helper.createScheduledNotification(
      id: _notificationId++,
      title: '🎄 Yılbaşı Yaklaşıyor!',
      body: '2025 yılının son ayındayız. Hedeflerinizi değerlendirin!',
      channelKey: 'general_channel',
      schedule: NotificationScheduleConverter.createCalendar(
        year: 2025,
        month: 12,
        day: 1,
        hour: 9,
        minute: 0,
      ),
      payload: {'type': 'year_end', 'year': '2025'},
    );
  }

  /// 5. Cron tabanlı bildirimler (sadece Android)
  static Future<void> sendCronBasedNotifications() async {
    // Her gün saat 14:30'da (Cron: "0 30 14 * * ?")
    await _helper.createScheduledNotification(
      id: _notificationId++,
      title: '☕ Öğleden Sonra Molası',
      body: 'Kahve molası zamanı!',
      channelKey: 'general_channel',
      schedule: NotificationScheduleConverter.createCron(
        cronExpression: '0 30 14 * * ?',
        preciseAlarm: true,
      ),
      payload: {'type': 'cron', 'schedule': 'daily_14_30'},
    );

    // Her Pazartesi, Çarşamba, Cuma saat 08:00'da (Cron: "0 0 8 * * MON,WED,FRI")
    await _helper.createScheduledNotification(
      id: _notificationId++,
      title: '🏃 Egzersiz Zamanı',
      body: 'Bugün spor günü! Formda kalmayı unutmayın.',
      channelKey: 'general_channel',
      schedule: NotificationScheduleConverter.createCron(
        cronExpression: '0 0 8 * * MON,WED,FRI',
        preciseAlarm: true,
      ),
      payload: {'type': 'cron', 'schedule': 'exercise_mwf'},
    );
  }

  /// 6. İş saatleri dışında bildirim gönderme
  static Future<void> sendBusinessHoursNotifications() async {
    final now = DateTime.now();
    
    // Eğer şu an iş saatleri içindeyse (9-17 arası), iş saatleri dışına planla
    DateTime scheduleTime;
    if (now.hour >= 9 && now.hour < 17) {
      // İş saatleri içinde, bugün 18:00'a planla
      scheduleTime = now.copyWith(hour: 18, minute: 0, second: 0);
    } else {
      // İş saatleri dışında, yarın 09:00'a planla
      scheduleTime = now.add(const Duration(days: 1))
          .copyWith(hour: 9, minute: 0, second: 0);
    }

    await _helper.createScheduledNotification(
      id: _notificationId++,
      title: '💼 İş Dışı Bildirim',
      body: 'Bu bildirim iş saatleri dışında size ulaştı',
      channelKey: 'general_channel',
      schedule: NotificationScheduleConverter.createExactDate(
        dateTime: scheduleTime,
        preciseAlarm: true,
      ),
      payload: {
        'type': 'business_hours',
        'scheduled_for': scheduleTime.toIso8601String(),
      },
    );
  }

  /// 7. Dinamik seri bildirimler
  static Future<void> sendSeriesNotifications() async {
    final baseTime = DateTime.now();
    
    // 1 dakika arayla 5 bildirim gönder
    for (int i = 1; i <= 5; i++) {
      final scheduleTime = baseTime.add(Duration(minutes: i));
      
      await _helper.createScheduledNotification(
        id: _notificationId++,
        title: '📋 Seri Bildirim $i/5',
        body: 'Bu serinin $i. bildirimi ($i dakika arayla)',
        channelKey: 'general_channel',
        schedule: NotificationScheduleConverter.createExactDate(
          dateTime: scheduleTime,
          preciseAlarm: true,
        ),
        payload: {
          'type': 'series',
          'series_number': i.toString(),
          'total_series': '5',
        },
      );
    }
  }

  /// 8. Özel saat dilimi ile bildirim
  static Future<void> sendTimezoneNotifications() async {
    // İstanbul saat diliminde yarın saat 12:00
    final tomorrowNoon = DateTime.now().add(const Duration(days: 1))
        .copyWith(hour: 12, minute: 0, second: 0);

    await _helper.createScheduledNotification(
      id: _notificationId++,
      title: '🌍 Saat Dilimi Bildirimi',
      body: 'Bu bildirim İstanbul saatiyle zamanlandı',
      channelKey: 'general_channel',
      schedule: NotificationScheduleConverter.createExactDate(
        dateTime: tomorrowNoon,
        preciseAlarm: true,
      ),
      payload: {
        'type': 'timezone',
        'timezone': 'Europe/Istanbul',
        'target_time': tomorrowNoon.toIso8601String(),
      },
    );
  }

  /// Tüm zamanlanmış bildirimleri iptal et
  static Future<void> cancelAllScheduledNotifications() async {
    await _helper.cancelAllNotifications();
  }

  /// Belirli türdeki bildirimleri iptal et
  static Future<void> cancelNotificationsByType(String type) async {
    // Bu örnekte basit ID aralığı kullanıyoruz
    // Gerçek uygulamada payload'a göre filtreleme yapabilirsiniz
    for (int id = 1000; id < _notificationId; id++) {
      await _helper.cancelNotification(id);
    }
  }

  /// Demo widget'ı oluştur
  static Widget createDemoWidget() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Zamanlanmış Bildirim Örnekleri'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              '⏰ Zamanlanmış Bildirim API Örnekleri',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            
            _buildDemoButton(
              'Gecikmeli Bildirimler (30sn, 5dk, 2sa)',
              sendDelayedNotifications,
              Colors.blue,
            ),
            _buildDemoButton(
              'Belirli Tarih/Saat Bildirimleri',
              sendExactDateNotifications,
              Colors.green,
            ),
            _buildDemoButton(
              'Tekrar Eden Bildirimler',
              sendRepeatingNotifications,
              Colors.orange,
            ),
            _buildDemoButton(
              'Gelişmiş Takvim Bildirimleri',
              sendAdvancedCalendarNotifications,
              Colors.purple,
            ),
            _buildDemoButton(
              'Cron Tabanlı Bildirimler (Android)',
              sendCronBasedNotifications,
              Colors.red,
            ),
            _buildDemoButton(
              'İş Saatleri Dışı Bildirim',
              sendBusinessHoursNotifications,
              Colors.teal,
            ),
            _buildDemoButton(
              'Seri Bildirimler (5 adet)',
              sendSeriesNotifications,
              Colors.indigo,
            ),
            _buildDemoButton(
              'Saat Dilimi Bildirimi',
              sendTimezoneNotifications,
              Colors.cyan,
            ),
            const SizedBox(height: 20),
            _buildDemoButton(
              'Tüm Bildirimleri İptal Et',
              cancelAllScheduledNotifications,
              Colors.grey,
            ),
          ],
        ),
      ),
    );
  }

  static Widget _buildDemoButton(String text, VoidCallback onPressed, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
