import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'user_permission_data.g.dart';

abstract class UserPermissionData
    implements Built<UserPermissionData, UserPermissionDataBuilder> {
  factory UserPermissionData([
    final void Function(UserPermissionDataBuilder) updates,
  ]) = _$UserPermissionData;

  UserPermissionData._();

  static Serializer<UserPermissionData> get serializer =>
      _$userPermissionDataSerializer;

  @BuiltValueHook(initializeBuilder: true)
  static void _initialize(final UserPermissionDataBuilder b) => b;

  bool? get canEditOrganization;
}
