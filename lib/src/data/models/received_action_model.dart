import 'package:awesome_notifications/awesome_notifications.dart';

/// Extension for AwesomeNotifications ReceivedAction
class ReceivedActionModel {
  final ReceivedAction _action;

  ReceivedActionModel(this._action);

  /// Channel key of the notification
  String? get channelKey => _action.channelKey;

  /// ID of the notification
  int? get id => _action.id;

  /// Title of the notification
  String? get title => _action.title;

  /// Body of the notification
  String? get body => _action.body;

  /// Payload data
  Map<String, String?>? get payload => _action.payload;

  /// Button key if action triggered by button
  String? get buttonKeyPressed => _action.buttonKeyPressed;

  /// Button key input if action triggered by input button
  String? get buttonKeyInput => _action.buttonKeyInput;

  /// Action type
  ActionType? get actionType => _action.actionType;

  /// Action date
  DateTime? get actionDate => _action.actionDate;

  /// Original ReceivedAction object
  ReceivedAction get originalAction => _action;

  @override
  String toString() {
    return 'ReceivedActionModel(channelKey: $channelKey, id: $id, title: $title, body: $body, payload: $payload)';
  }
}
