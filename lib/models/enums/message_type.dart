// ignore_for_file: prefer_final_parameters

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'message_type.g.dart';

class MessageType extends EnumClass {
  static Serializer<MessageType> get serializer => _$messageTypeSerializer;

  static BuiltSet<MessageType> get values => _$values;

  static MessageType valueOf(String name) => _$valueOf(name);

  static const MessageType text = _$text;
  static const MessageType image = _$image;
  static const MessageType video = _$video;
  static const MessageType file = _$file;
  static const MessageType meeting = _$meeting;
  @BuiltValueEnumConst(fallback: true)
  static const MessageType unknown = _$unknown;

  const MessageType._(String name) : super(name);
}
