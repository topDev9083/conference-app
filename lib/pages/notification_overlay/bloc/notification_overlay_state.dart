import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';

import 'notification_popup_item.dart';

part 'notification_overlay_state.g.dart';

abstract class NotificationOverlayState
    implements
        Built<NotificationOverlayState, NotificationOverlayStateBuilder> {
  factory NotificationOverlayState([
    final void Function(NotificationOverlayStateBuilder) updates,
  ]) = _$NotificationOverlayState;

  NotificationOverlayState._();

  static void _initializeBuilder(final NotificationOverlayStateBuilder b) => b;

  BuiltList<NotificationPopupItem> get notifications;
}
