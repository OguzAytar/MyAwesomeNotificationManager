# Changelog

## 0.0.2

### New Features

* **Custom Schedule API:**
  - `NotificationScheduleModel` hierarchy (Interval, Calendar, Cron, ExactDate)
  - `NotificationScheduleConverter` with helper methods
  - Abstracted awesome_notifications dependency from public API
  - Easy-to-use schedule builders (afterMinutes, dailyAt, weeklyAt, etc.)

* **Enhanced Examples:**
  - Complete schedule examples in `/example/schedule_examples.dart`
  - Updated main example app with new schedule API
  - Comprehensive schedule use cases and patterns

* **Documentation:**
  - Updated README.md with schedule API documentation
  - Enhanced quick guide with schedule reference
  - Added schedule-specific examples and best practices

### Breaking Changes

* `createScheduledNotification` now uses `NotificationScheduleModel` instead of `NotificationSchedule`
* Removed direct awesome_notifications types from public interface

## 0.0.1

### Initial Release

* **Core Features:**
  - Layered architecture implementation for AwesomeNotifications
  - Base notification handler abstract class
  - Type-safe notification models (TReceivedActionModel, TReceivedNotificationModel)
  - Notification service with handler-based system
  - Notification helper with CRUD operations

* **Notification Types:**
  - Simple notifications
  - Scheduled notifications
  - Big picture notifications
  - Notifications with action buttons

* **Management Features:**
  - Permission handling
  - Channel and channel group management
  - Notification lifecycle management
  - Error handling and logging

* **Architecture:**
  - Clean separation of concerns
  - Interface-based design
  - Extensible handler system
  - Easy integration and testing
