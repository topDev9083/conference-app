import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import '../serializers.dart';
import 'user_data.dart';

part 'group_data.g.dart';

abstract class GroupData implements Built<GroupData, GroupDataBuilder> {
  factory GroupData([final void Function(GroupDataBuilder) updates]) =
      _$GroupData;

  GroupData._();

  static Serializer<GroupData> get serializer => _$groupDataSerializer;

  static void _initializeBuilder(final GroupDataBuilder b) => b;

  int get id;

  String get updatedOn;

  String get createdOn;

  String get name;

  bool get isReadonly;

  // custom fields
  BuiltList<UserData>? get users;

  // from joining
  int? get userId;

  int? get userCounts;

  int? get announcementId;

  static GroupData fromDynamic(final dynamic json) {
    return serializers.deserializeWith(GroupData.serializer, json)!;
  }
}
