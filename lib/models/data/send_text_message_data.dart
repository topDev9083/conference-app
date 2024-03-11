import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import '../enums/message_type.dart';
import '../serializers.dart';

part 'send_text_message_data.g.dart';

abstract class SendTextMessageData
    implements Built<SendTextMessageData, SendTextMessageDataBuilder> {
  factory SendTextMessageData([
    final void Function(SendTextMessageDataBuilder) updates,
  ]) = _$SendTextMessageData;

  SendTextMessageData._();

  static Serializer<SendTextMessageData> get serializer =>
      _$sendTextMessageDataSerializer;

  static void _initializeBuilder(final SendTextMessageDataBuilder b) => b;

  String get message;

  int get toUserId;

  MessageType get type;

  dynamic toDynamic() {
    return serializers.serializeWith<SendTextMessageData>(
      SendTextMessageData.serializer,
      this,
    );
  }
}
