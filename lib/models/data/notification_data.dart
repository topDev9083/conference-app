import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import '../serializers.dart';

part 'notification_data.g.dart';

abstract class NotificationData
    implements Built<NotificationData, NotificationDataBuilder> {
  factory NotificationData([
    final void Function(NotificationDataBuilder) updates,
  ]) = _$NotificationData;

  NotificationData._();

  static Serializer<NotificationData> get serializer =>
      _$notificationDataSerializer;

  static void _initializeBuilder(final NotificationDataBuilder b) => b;

  String get title;

  String get body;

  static NotificationData fromDynamic(final dynamic json) {
    return serializers.deserializeWith(NotificationData.serializer, json)!;
  }
}
