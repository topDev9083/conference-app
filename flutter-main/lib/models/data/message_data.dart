import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import '../enums/message_type.dart';
import '../serializers.dart';

part 'message_data.g.dart';

abstract class MessageData implements Built<MessageData, MessageDataBuilder> {
  factory MessageData([final void Function(MessageDataBuilder) updates]) =
      _$MessageData;

  MessageData._();

  static Serializer<MessageData> get serializer => _$messageDataSerializer;

  static void _initializeBuilder(final MessageDataBuilder b) => b;

  int get id;

  String get updatedOn;

  DateTime get createdOn;

  String? get message;

  String? get fileUrl;

  MessageType get type;

  int get fromUserId;

  int get toUserId;

  bool get isRead;

  int? get meetingId;

  // from joining
  String? get fromUserFirstName;

  String? get fromUserLastName;

  String? get fromUserProfilePicture;

  String get fromUserFullName => '$fromUserFirstName $fromUserLastName';

  String get fromUserInitials =>
      '${fromUserFirstName?.substring(0, 1)}${fromUserLastName?.substring(0, 1)}'
          .toUpperCase();

  static MessageData fromDynamic(final dynamic json) {
    return serializers.deserializeWith(MessageData.serializer, json)!;
  }

  static BuiltList<MessageData> fromDynamics(final List<dynamic> list) {
    return BuiltList(list.map((final json) => fromDynamic(json)));
  }
}
