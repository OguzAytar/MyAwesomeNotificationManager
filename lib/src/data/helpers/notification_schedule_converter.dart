import 'package:awesome_notifications/awesome_notifications.dart';

import '../models/notification_schedule_model.dart';

/// Converts our notification schedule models to AwesomeNotifications schedule
class NotificationScheduleConverter {
  /// Convert our schedule model to AwesomeNotifications schedule
  static NotificationSchedule convertToAwesome(NotificationScheduleModel scheduleModel) {
    if (scheduleModel is NotificationIntervalModel) {
      return NotificationInterval(
        interval: Duration(seconds: scheduleModel.interval),
        timeZone: scheduleModel.timeZone,
        preciseAlarm: scheduleModel.preciseAlarm,
        allowWhileIdle: scheduleModel.allowWhileIdle,
        repeats: scheduleModel.repeats,
      );
    } else if (scheduleModel is NotificationCalendarModel) {
      return NotificationCalendar(
        year: scheduleModel.year,
        month: scheduleModel.month,
        day: scheduleModel.day,
        hour: scheduleModel.hour,
        minute: scheduleModel.minute,
        second: scheduleModel.second,
        weekday: scheduleModel.weekday,
        timeZone: scheduleModel.timeZone,
        preciseAlarm: scheduleModel.preciseAlarm,
        allowWhileIdle: scheduleModel.allowWhileIdle,
        repeats: scheduleModel.repeats,
      );
    } else if (scheduleModel is NotificationCronModel) {
      return NotificationAndroidCrontab(
        crontabExpression: scheduleModel.cronExpression,
        preciseAlarm: scheduleModel.preciseAlarm,
        allowWhileIdle: scheduleModel.allowWhileIdle,
      );
    } else if (scheduleModel is NotificationExactDateModel) {
      return NotificationCalendar.fromDate(
        date: scheduleModel.dateTime,
        preciseAlarm: scheduleModel.preciseAlarm,
        allowWhileIdle: scheduleModel.allowWhileIdle,
        repeats: scheduleModel.repeats,
      );
    }

    throw ArgumentError('Unsupported schedule model type: ${scheduleModel.runtimeType}');
  }

  /// Create interval schedule helper
  static NotificationIntervalModel createInterval({
    required int seconds,
    String? timeZone,
    bool preciseAlarm = true,
    bool allowWhileIdle = false,
    bool repeats = false,
  }) {
    return NotificationIntervalModel(
      interval: seconds,
      timeZone: timeZone,
      preciseAlarm: preciseAlarm,
      allowWhileIdle: allowWhileIdle,
      repeats: repeats,
    );
  }

  /// Create calendar schedule helper
  static NotificationCalendarModel createCalendar({
    int? year,
    int? month,
    int? day,
    int? hour,
    int? minute,
    int? second,
    int? weekday,
    String? timeZone,
    bool preciseAlarm = true,
    bool allowWhileIdle = false,
    bool repeats = false,
  }) {
    return NotificationCalendarModel(
      year: year,
      month: month,
      day: day,
      hour: hour,
      minute: minute,
      second: second,
      weekday: weekday,
      timeZone: timeZone,
      preciseAlarm: preciseAlarm,
      allowWhileIdle: allowWhileIdle,
      repeats: repeats,
    );
  }

  /// Create exact date schedule helper
  static NotificationExactDateModel createExactDate({
    required DateTime dateTime,
    bool preciseAlarm = true,
    bool allowWhileIdle = false,
    bool repeats = false,
  }) {
    return NotificationExactDateModel(dateTime: dateTime, preciseAlarm: preciseAlarm, allowWhileIdle: allowWhileIdle, repeats: repeats);
  }

  /// Create cron schedule helper (Android only)
  static NotificationCronModel createCron({required String cronExpression, String? timeZone, bool preciseAlarm = true, bool allowWhileIdle = false}) {
    return NotificationCronModel(cronExpression: cronExpression, timeZone: timeZone, preciseAlarm: preciseAlarm, allowWhileIdle: allowWhileIdle);
  }

  /// Quick schedule helpers

  /// Schedule after X minutes
  static NotificationIntervalModel afterMinutes(int minutes) {
    return createInterval(seconds: minutes * 60);
  }

  /// Schedule after X hours
  static NotificationIntervalModel afterHours(int hours) {
    return createInterval(seconds: hours * 3600);
  }

  /// Schedule after X days
  static NotificationIntervalModel afterDays(int days) {
    return createInterval(seconds: days * 24 * 3600);
  }

  /// Schedule daily at specific time
  static NotificationCalendarModel dailyAt({required int hour, required int minute}) {
    return createCalendar(hour: hour, minute: minute, repeats: true);
  }

  /// Schedule weekly on specific weekday and time
  static NotificationCalendarModel weeklyAt({required int weekday, required int hour, required int minute}) {
    return createCalendar(weekday: weekday, hour: hour, minute: minute, repeats: true);
  }

  /// Schedule monthly on specific day and time
  static NotificationCalendarModel monthlyAt({required int day, required int hour, required int minute}) {
    return createCalendar(day: day, hour: hour, minute: minute, repeats: true);
  }
}
