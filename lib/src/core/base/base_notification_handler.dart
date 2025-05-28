import 'package:ogzawesomenotificationmanager/src/data/models/received_action_model.dart';
import 'package:ogzawesomenotificationmanager/src/data/models/received_notification_model.dart';

/// Base notification handler abstract class
abstract class BaseNotificationHandler {
  /// Action to be performed when notification is clicked
  @pragma('vm:entry-point')
  Future<void> onActionReceived(ReceivedActionModel action);

  /// Action to be performed when notification is created
  @pragma('vm:entry-point')
  Future<void> onNotificationCreated(ReceivedNotificationModel notification);

  /// Action to be performed when notification is displayed
  @pragma('vm:entry-point')
  Future<void> onNotificationDisplayed(ReceivedNotificationModel notification);

  /// Action to be performed when notification is dismissed
  @pragma('vm:entry-point')
  Future<void> onDismissActionReceived(ReceivedActionModel action);
}
