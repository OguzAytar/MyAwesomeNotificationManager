import 'package:flutter/material.dart';

/// Custom notification channel model to abstract away awesome_notifications dependency
class NotificationChannelModel {
  final String channelKey;
  final String channelName;
  final String channelDescription;
  final String? channelGroupKey;
  final Color? defaultColor;
  final bool enableLights;
  final bool enableVibration;
  final NotificationImportanceModel importance;
  final bool playSound;
  final String? soundSource;
  final bool locked;
  final String? groupAlertBehavior;
  final bool onlyAlertOnce;
  final bool criticalAlerts;
  final String? icon;
  final String? defaultPrivacy;
  final String? groupKey;
  final String? groupSort;
  final bool enableChannelVibration;
  final List<int>? vibrationPattern;
  final Color? ledColor;
  final int? ledOnMs;
  final int? ledOffMs;

  const NotificationChannelModel({
    required this.channelKey,
    required this.channelName,
    required this.channelDescription,
    this.channelGroupKey,
    this.defaultColor,
    this.enableLights = true,
    this.enableVibration = true,
    this.importance = NotificationImportanceModel.high,
    this.playSound = true,
    this.soundSource,
    this.locked = false,
    this.groupAlertBehavior,
    this.onlyAlertOnce = false,
    this.criticalAlerts = false,
    this.icon,
    this.defaultPrivacy,
    this.groupKey,
    this.groupSort,
    this.enableChannelVibration = true,
    this.vibrationPattern,
    this.ledColor,
    this.ledOnMs,
    this.ledOffMs,
  });

  @override
  String toString() {
    return 'NotificationChannelModel(channelKey: $channelKey, channelName: $channelName, importance: $importance)';
  }
}

/// Custom notification channel group model
class NotificationChannelGroupModel {
  final String channelGroupKey;
  final String channelGroupName;
  final String? channelGroupDescription;

  const NotificationChannelGroupModel({
    required this.channelGroupKey,
    required this.channelGroupName,
    this.channelGroupDescription,
  });

  @override
  String toString() {
    return 'NotificationChannelGroupModel(channelGroupKey: $channelGroupKey, channelGroupName: $channelGroupName)';
  }
}

/// Custom notification importance enum
enum NotificationImportanceModel {
  none,
  min,
  low,
  default_,
  high,
  max,
}

/// Custom notification action button model
class NotificationActionButtonModel {
  final String key;
  final String label;
  final String? icon;
  final bool enabled;
  final bool autoDismissible;
  final bool showInCompactView;
  final bool isDangerousOption;
  final ActionTypeModel actionType;
  final Color? color;

  const NotificationActionButtonModel({
    required this.key,
    required this.label,
    this.icon,
    this.enabled = true,
    this.autoDismissible = true,
    this.showInCompactView = true,
    this.isDangerousOption = false,
    this.actionType = ActionTypeModel.defaultAction,
    this.color,
  });

  @override
  String toString() {
    return 'NotificationActionButtonModel(key: $key, label: $label, actionType: $actionType)';
  }
}

/// Custom action type enum
enum ActionTypeModel {
  defaultAction,
  silentAction,
  silentBackgroundAction,
  keepOnTop,
  inputField,
  disabledAction,
}

/// Custom notification layout enum
enum NotificationLayoutModel {
  default_,
  bigPicture,
  bigText,
  inbox,
  messaging,
  messagingGroup,
  mediaPlayer,
  decoration,
  progressBar,
  custom,
}

/// Custom notification content model
class NotificationContentModel {
  final int id;
  final String channelKey;
  final String? title;
  final String? body;
  final Map<String, String?>? payload;
  final String? summary;
  final bool? showWhen;
  final bool? displayOnForeground;
  final bool? displayOnBackground;
  final String? icon;
  final String? largeIcon;
  final String? bigPicture;
  final bool? autoCancel;
  final Color? color;
  final Color? backgroundColor;
  final NotificationLayoutModel? notificationLayout;
  final int? progress;
  final bool? locked;
  final String? ticker;
  final bool? fullScreenIntent;
  final bool? wakeUpScreen;
  final String? category;
  final bool? criticalAlert;
  final String? customSound;

  const NotificationContentModel({
    required this.id,
    required this.channelKey,
    this.title,
    this.body,
    this.payload,
    this.summary,
    this.showWhen,
    this.displayOnForeground,
    this.displayOnBackground,
    this.icon,
    this.largeIcon,
    this.bigPicture,
    this.autoCancel,
    this.color,
    this.backgroundColor,
    this.notificationLayout,
    this.progress,
    this.locked,
    this.ticker,
    this.fullScreenIntent,
    this.wakeUpScreen,
    this.category,
    this.criticalAlert,
    this.customSound,
  });

  @override
  String toString() {
    return 'NotificationContentModel(id: $id, channelKey: $channelKey, title: $title)';
  }
}
