/// Base class for notification scheduling
abstract class NotificationScheduleModel {
  const NotificationScheduleModel();
}

/// Schedule a notification after a specific interval
class NotificationIntervalModel extends NotificationScheduleModel {
  final int interval; // Seconds
  final String? timeZone;
  final bool preciseAlarm;
  final bool allowWhileIdle;
  final bool repeats;

  const NotificationIntervalModel({
    required this.interval,
    this.timeZone,
    this.preciseAlarm = true,
    this.allowWhileIdle = false,
    this.repeats = false,
  });
}

/// Schedule a notification at a specific date and time
class NotificationCalendarModel extends NotificationScheduleModel {
  final int? year;
  final int? month;
  final int? day;
  final int? hour;
  final int? minute;
  final int? second;
  final int? weekday;
  final String? timeZone;
  final bool preciseAlarm;
  final bool allowWhileIdle;
  final bool repeats;

  const NotificationCalendarModel({
    this.year,
    this.month,
    this.day,
    this.hour,
    this.minute,
    this.second,
    this.weekday,
    this.timeZone,
    this.preciseAlarm = true,
    this.allowWhileIdle = false,
    this.repeats = false,
  });
}

/// Schedule a notification with cron expression
class NotificationCronModel extends NotificationScheduleModel {
  final String cronExpression;
  final String? timeZone;
  final bool preciseAlarm;
  final bool allowWhileIdle;

  const NotificationCronModel({required this.cronExpression, this.timeZone, this.preciseAlarm = true, this.allowWhileIdle = false});
}

/// Schedule notification at exact date and time
class NotificationExactDateModel extends NotificationScheduleModel {
  final DateTime dateTime;
  final bool preciseAlarm;
  final bool allowWhileIdle;
  final bool repeats;

  const NotificationExactDateModel({required this.dateTime, this.preciseAlarm = true, this.allowWhileIdle = false, this.repeats = false});
}
