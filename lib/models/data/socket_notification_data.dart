import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'notification_data.dart';

part 'socket_notification_data.g.dart';

abstract class SocketNotificationData<T>
    implements
        Built<SocketNotificationData<T>, SocketNotificationDataBuilder<T>> {
  factory SocketNotificationData([
    final void Function(SocketNotificationDataBuilder<T>) updates,
  ]) = _$SocketNotificationData<T>;

  SocketNotificationData._();

  static Serializer<SocketNotificationData> get serializer =>
      _$socketNotificationDataSerializer;

  @BuiltValueHook(initializeBuilder: true)
  static void _initialize(final SocketNotificationDataBuilder b) => b;

  NotificationData get notification;

  T get body;
}
