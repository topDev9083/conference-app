import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import '../serializers.dart';
import 'role_data.dart';
import 'user_data.dart';

part 'session_user_data.g.dart';

abstract class SessionUserData
    implements Built<SessionUserData, SessionUserDataBuilder> {
  factory SessionUserData([
    final void Function(SessionUserDataBuilder) updates,
  ]) = _$SessionUserData;

  SessionUserData._();

  static Serializer<SessionUserData> get serializer =>
      _$sessionUserDataSerializer;

  static void _initializeBuilder(final SessionUserDataBuilder b) => b;

  String get updatedOn;

  String get createdOn;

  int get sessionId;

  int get userId;

  int? get roleId;

  UserData? get user;

  RoleData? get role;

  static SessionUserData fromDynamic(final dynamic json) {
    return serializers.deserializeWith(SessionUserData.serializer, json)!;
  }
}
