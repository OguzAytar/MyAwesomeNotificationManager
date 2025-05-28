# OGZ Awesome Notification Manager

A Flutter package that provides a layered architecture wrapper for [awesome_notifications](https://pub.dev/packages/awesome_notifications). This package simplifies notification management with a clean, maintainable structure.

## Features

- **Layered Architecture**: Clean separation of concerns with data, core, and presentation layers
- **Handler-based System**: Custom notification handlers for different channels
- **Type-safe Models**: Wrapper models for notification data
- **Easy Integration**: Simple initialization and usage
- **Multiple Notification Types**: Support for simple, scheduled, big picture, and action button notifications
- **Permission Management**: Built-in permission handling
- **Lifecycle Management**: Automatic handling of notification events

## Getting Started

### Installation

Add this package to your `pubspec.yaml`:

```yaml
dependencies:
  ogzawesomenotificationmanager:
    path: ../path/to/ogzawesomenotificationmanager
```

### Basic Usage

1. **Create a notification handler:**

```dart
class MyNotificationHandler extends BaseNotificationHandler {
  @override
  Future<void> onActionReceived(TReceivedActionModel action) async {
    // Handle notification tap
    print('Notification tapped: ${action.title}');
  }

  @override
  Future<void> onNotificationCreated(TReceivedNotificationModel notification) async {
    // Handle notification creation
  }

  @override
  Future<void> onNotificationDisplayed(TReceivedNotificationModel notification) async {
    // Handle notification display
  }

  @override
  Future<void> onDismissActionReceived(TReceivedActionModel action) async {
    // Handle notification dismiss
  }
}
```

2. **Initialize the notification service:**

```dart
Future<void> initializeNotifications() async {
  final handlers = {
    'my_channel': MyNotificationHandler(),
  };

  final channels = [
    NotificationChannel(
      channelKey: 'my_channel',
      channelName: 'My Notifications',
      channelDescription: 'My notification channel',
      defaultColor: Colors.blue,
      importance: NotificationImportance.High,
    ),
  ];

  await NotificationService.initializeNotifications(
    handlers,
    channels: channels,
  );

  await NotificationService.setListeners();
  await NotificationService.requestPermissions();
}
```

3. **Send notifications:**

```dart
final helper = NotificationHelper();

// Simple notification
await helper.createNotification(
  id: 1,
  title: 'Hello',
  body: 'This is a test notification',
  channelKey: 'my_channel',
);

// Scheduled notification
await helper.createScheduledNotification(
  id: 2,
  title: 'Reminder',
  body: 'Don\'t forget!',
  channelKey: 'my_channel',
  schedule: NotificationInterval(interval: 60),
);
```

## Architecture

The package follows a layered architecture pattern:

```
lib/
├── src/
│   ├── core/                  # Core abstractions and interfaces
│   │   ├── base/
│   │   └── interfaces/
│   ├── data/                  # Data layer (models, helpers)
│   │   ├── models/
│   │   └── helpers/
│   └── presentation/          # Presentation layer (services, controllers)
│       ├── services/
│       └── controllers/
```

### Core Layer
- `BaseNotificationHandler`: Abstract class for implementing notification handlers
- `INotificationServiceHelper`: Interface for notification helper services

### Data Layer
- `TReceivedActionModel`: Wrapper for notification action data
- `TReceivedNotificationModel`: Wrapper for notification data
- `NotificationHelper`: Implementation of notification operations

### Presentation Layer
- `NotificationService`: Main service for managing notifications
- `NotificationController`: Controller for handling notification events

TODO: List prerequisites and provide or point to information on how to
start using the package.

## Usage

TODO: Include short and useful examples for package users. Add longer examples
to `/example` folder.

```dart
const like = 'sample';
```

## Additional information

TODO: Tell users more about the package: where to find more information, how to
contribute to the package, how to file issues, what response they can expect
from the package authors, and more.
