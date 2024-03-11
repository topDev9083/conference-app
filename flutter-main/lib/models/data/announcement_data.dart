import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import '../enums/announcement_send_as.dart';
import '../enums/announcement_send_to.dart';
import '../serializers.dart';
import 'group_data.dart';
import 'role_data.dart';
import 'user_data.dart';

part 'announcement_data.g.dart';

abstract class AnnouncementData
    implements Built<AnnouncementData, AnnouncementDataBuilder> {
  factory AnnouncementData([
    final void Function(AnnouncementDataBuilder) updates,
  ]) = _$AnnouncementData;

  AnnouncementData._();

  static Serializer<AnnouncementData> get serializer =>
      _$announcementDataSerializer;

  static void _initializeBuilder(final AnnouncementDataBuilder b) => b;

  int get id;

  String get updatedOn;

  String get createdOn;

  String get subject;

  String get message;

  AnnouncementSendTo get sendTo;

  BuiltList<AnnouncementSendAs> get sendAs;

  // custom fields
  BuiltList<UserData>? get users;

  BuiltList<GroupData>? get groups;

  BuiltList<RoleData>? get roles;

  // from joining
  bool? get isRead;

  static AnnouncementData fromDynamic(final dynamic json) {
    return serializers.deserializeWith(AnnouncementData.serializer, json)!;
  }

  static BuiltList<AnnouncementData> fromDynamics(final List<dynamic> list) {
    return BuiltList<AnnouncementData>(
      list.map(
        (final json) => fromDynamic(json),
      ),
    );
  }
}
