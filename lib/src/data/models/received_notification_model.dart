import 'package:awesome_notifications/awesome_notifications.dart';

/// Extension for AwesomeNotifications ReceivedNotification
class ReceivedNotificationModel {
  final ReceivedNotification _notification;

  ReceivedNotificationModel(this._notification);

  /// Channel key of the notification
  String? get channelKey => _notification.channelKey;

  /// ID of the notification
  int? get id => _notification.id;

  /// Title of the notification
  String? get title => _notification.title;

  /// Body of the notification
  String? get body => _notification.body;

  /// Payload data
  Map<String, String?>? get payload => _notification.payload;

  /// Created date
  DateTime? get createdDate => _notification.createdDate;

  /// Displayed date
  DateTime? get displayedDate => _notification.displayedDate;

  /// Large icon
  String? get largeIcon => _notification.largeIcon;

  /// Big picture
  String? get bigPicture => _notification.bigPicture;

  /// Custom sound
  String? get customSound => _notification.customSound;

  /// Original ReceivedNotification object
  ReceivedNotification get originalNotification => _notification;

  @override
  String toString() {
    return 'ReceivedNotificationModel(channelKey: $channelKey, id: $id, title: $title, body: $body, payload: $payload)';
  }
}
