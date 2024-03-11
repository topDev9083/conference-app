import 'package:built_value/built_value.dart';
import 'package:flutter/material.dart' show VoidCallback;

part 'notification_popup_item.g.dart';

abstract class NotificationPopupItem
    implements Built<NotificationPopupItem, NotificationPopupItemBuilder> {
  factory NotificationPopupItem([
    final void Function(NotificationPopupItemBuilder) updates,
  ]) = _$NotificationPopupItem;

  factory NotificationPopupItem.create({
    required final String id,
    required final String title,
    required final String subtitle,
    final VoidCallback? onTap,
  }) =>
      NotificationPopupItem(
        (final b) => b
          ..id = id
          ..title = title
          ..subtitle = subtitle
          ..onTap = onTap,
      );

  NotificationPopupItem._();

  @BuiltValueHook(initializeBuilder: true)
  static void _initialize(final NotificationPopupItemBuilder b) => b;

  String get id;

  String get title;

  String get subtitle;

  VoidCallback? get onTap;
}
