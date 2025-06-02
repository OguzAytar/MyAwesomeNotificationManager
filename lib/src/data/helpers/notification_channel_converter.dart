import 'dart:typed_data';

import 'package:awesome_notifications/awesome_notifications.dart';

import '../models/notification_channel_model.dart';

/// Converts our custom channel models to AwesomeNotifications models
class NotificationChannelConverter {
  /// Convert our channel model to AwesomeNotifications channel
  static NotificationChannel convertChannel(NotificationChannelModel channelModel) {
    return NotificationChannel(
      channelKey: channelModel.channelKey,
      channelName: channelModel.channelName,
      channelDescription: channelModel.channelDescription,
      channelGroupKey: channelModel.channelGroupKey,
      defaultColor: channelModel.defaultColor,
      enableLights: channelModel.enableLights,
      enableVibration: channelModel.enableVibration,
      importance: _convertImportance(channelModel.importance),
      playSound: channelModel.playSound,
      soundSource: channelModel.soundSource,
      locked: channelModel.locked,
      onlyAlertOnce: channelModel.onlyAlertOnce,
      criticalAlerts: channelModel.criticalAlerts,
      icon: channelModel.icon,
      defaultPrivacy: _convertPrivacy(channelModel.defaultPrivacy),
      groupKey: channelModel.groupKey,
      groupSort: _convertGroupSort(channelModel.groupSort),
      vibrationPattern: channelModel.vibrationPattern != null ? Int64List.fromList(channelModel.vibrationPattern!) : null,
      ledColor: channelModel.ledColor,
      ledOnMs: channelModel.ledOnMs,
      ledOffMs: channelModel.ledOffMs,
    );
  }

  /// Convert our channel group model to AwesomeNotifications channel group
  static NotificationChannelGroup convertChannelGroup(NotificationChannelGroupModel groupModel) {
    return NotificationChannelGroup(channelGroupKey: groupModel.channelGroupKey, channelGroupName: groupModel.channelGroupName);
  }

  /// Convert our action button model to AwesomeNotifications action button
  static NotificationActionButton convertActionButton(NotificationActionButtonModel buttonModel) {
    return NotificationActionButton(
      key: buttonModel.key,
      label: buttonModel.label,
      icon: buttonModel.icon,
      enabled: buttonModel.enabled,
      autoDismissible: buttonModel.autoDismissible,
      showInCompactView: buttonModel.showInCompactView,
      isDangerousOption: buttonModel.isDangerousOption,
      actionType: _convertActionType(buttonModel.actionType),
      color: buttonModel.color,
    );
  }

  /// Convert our content model to AwesomeNotifications content
  static NotificationContent convertContent(NotificationContentModel contentModel) {
    return NotificationContent(
      id: contentModel.id,
      channelKey: contentModel.channelKey,
      title: contentModel.title,
      body: contentModel.body,
      payload: contentModel.payload,
      summary: contentModel.summary,
      showWhen: contentModel.showWhen ?? true,
      displayOnForeground: contentModel.displayOnForeground ?? true,
      displayOnBackground: contentModel.displayOnBackground ?? true,
      icon: contentModel.icon,
      largeIcon: contentModel.largeIcon,
      bigPicture: contentModel.bigPicture,
      color: contentModel.color,
      backgroundColor: contentModel.backgroundColor,
      notificationLayout: contentModel.notificationLayout != null ? _convertLayout(contentModel.notificationLayout!) : NotificationLayout.Default,
      progress: contentModel.progress?.toDouble(),
      locked: contentModel.locked ?? false,
      ticker: contentModel.ticker,
      fullScreenIntent: contentModel.fullScreenIntent ?? false,
      wakeUpScreen: contentModel.wakeUpScreen ?? false,
      category: _convertCategory(contentModel.category),
      criticalAlert: contentModel.criticalAlert ?? false,
      customSound: contentModel.customSound,
    );
  }

  /// Convert importance enum
  static NotificationImportance _convertImportance(NotificationImportanceModel importance) {
    switch (importance) {
      case NotificationImportanceModel.none:
        return NotificationImportance.None;
      case NotificationImportanceModel.min:
        return NotificationImportance.Min;
      case NotificationImportanceModel.low:
        return NotificationImportance.Low;
      case NotificationImportanceModel.default_:
        return NotificationImportance.Default;
      case NotificationImportanceModel.high:
        return NotificationImportance.High;
      case NotificationImportanceModel.max:
        return NotificationImportance.Max;
    }
  }

  /// Convert action type enum
  static ActionType _convertActionType(ActionTypeModel actionType) {
    switch (actionType) {
      case ActionTypeModel.defaultAction:
        return ActionType.Default;
      case ActionTypeModel.silentAction:
        return ActionType.SilentAction;
      case ActionTypeModel.silentBackgroundAction:
        return ActionType.SilentBackgroundAction;
      case ActionTypeModel.keepOnTop:
        return ActionType.KeepOnTop;
      case ActionTypeModel.inputField:
        return ActionType.InputField;
      case ActionTypeModel.disabledAction:
        return ActionType.DisabledAction;
    }
  }

  /// Convert layout enum
  static NotificationLayout _convertLayout(NotificationLayoutModel layout) {
    switch (layout) {
      case NotificationLayoutModel.default_:
        return NotificationLayout.Default;
      case NotificationLayoutModel.bigPicture:
        return NotificationLayout.BigPicture;
      case NotificationLayoutModel.bigText:
        return NotificationLayout.BigText;
      case NotificationLayoutModel.inbox:
        return NotificationLayout.Inbox;
      case NotificationLayoutModel.messaging:
        return NotificationLayout.Messaging;
      case NotificationLayoutModel.messagingGroup:
        return NotificationLayout.MessagingGroup;
      case NotificationLayoutModel.mediaPlayer:
        return NotificationLayout.MediaPlayer;
      case NotificationLayoutModel.progressBar:
        return NotificationLayout.ProgressBar;
      case NotificationLayoutModel.decoration:
      case NotificationLayoutModel.custom:
        return NotificationLayout.Default; // Fallback to default for unsupported layouts
    }
  }

  /// Convert privacy enum (if needed)
  static NotificationPrivacy? _convertPrivacy(String? privacy) {
    if (privacy == null) return null;
    switch (privacy.toLowerCase()) {
      case 'public':
        return NotificationPrivacy.Public;
      case 'private':
        return NotificationPrivacy.Private;
      case 'secret':
        return NotificationPrivacy.Secret;
      default:
        return null;
    }
  }

  /// Convert group sort (if needed)
  static GroupSort? _convertGroupSort(String? groupSort) {
    if (groupSort == null) return null;
    switch (groupSort.toLowerCase()) {
      case 'asc':
        return GroupSort.Asc;
      case 'desc':
        return GroupSort.Desc;
      default:
        return null;
    }
  }

  /// Convert category (if needed)
  static NotificationCategory? _convertCategory(String? category) {
    if (category == null) return null;
    switch (category.toLowerCase()) {
      case 'alarm':
        return NotificationCategory.Alarm;
      case 'call':
        return NotificationCategory.Call;
      case 'email':
        return NotificationCategory.Email;
      case 'error':
        return NotificationCategory.Error;
      case 'event':
        return NotificationCategory.Event;
      case 'message':
        return NotificationCategory.Message;
      case 'navigation':
        return NotificationCategory.Navigation;
      case 'progress':
        return NotificationCategory.Progress;
      case 'promo':
        return NotificationCategory.Promo;
      case 'recommendation':
        return NotificationCategory.Recommendation;
      case 'reminder':
        return NotificationCategory.Reminder;
      case 'service':
        return NotificationCategory.Service;
      case 'social':
        return NotificationCategory.Social;
      case 'status':
        return NotificationCategory.Status;
      case 'system':
        return NotificationCategory.Service; // Use Service as fallback for system
      case 'transport':
        return NotificationCategory.Transport;
      default:
        return null;
    }
  }

  /// Helper method to convert list of channels
  static List<NotificationChannel> convertChannels(List<NotificationChannelModel> channels) {
    return channels.map((channel) => convertChannel(channel)).toList();
  }

  /// Helper method to convert list of channel groups
  static List<NotificationChannelGroup> convertChannelGroups(List<NotificationChannelGroupModel> groups) {
    return groups.map((group) => convertChannelGroup(group)).toList();
  }

  /// Helper method to convert list of action buttons
  static List<NotificationActionButton> convertActionButtons(List<NotificationActionButtonModel> buttons) {
    return buttons.map((button) => convertActionButton(button)).toList();
  }
}
