import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import '../serializers.dart';
import 'user_data.dart';

part 'role_data.g.dart';

abstract class RoleData implements Built<RoleData, RoleDataBuilder> {
  factory RoleData([final void Function(RoleDataBuilder) updates]) = _$RoleData;

  RoleData._();

  static Serializer<RoleData> get serializer => _$roleDataSerializer;

  static void _initializeBuilder(final RoleDataBuilder b) => b;

  int get id;

  String get updatedOn;

  String get createdOn;

  String get name;

  bool get isReadonly;

  // self created
  BuiltList<UserData>? get users;

  // from joining
  int? get userId;

  int? get userCounts;

  int? get announcementId;

  static RoleData fromDynamic(final dynamic json) {
    return serializers.deserializeWith(RoleData.serializer, json)!;
  }
}
