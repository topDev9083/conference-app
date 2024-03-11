import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/serializer.dart';

import '../serializers.dart';
import 'custom_column_data.dart';
import 'custom_field_data.dart';
import 'group_data.dart';
import 'meeting_data.dart';
import 'organization_data.dart';
import 'session_data.dart';
import 'user_permission_data.dart';

part 'user_data.g.dart';

abstract class UserData implements Built<UserData, UserDataBuilder> {
  factory UserData([final void Function(UserDataBuilder) updates]) = _$UserData;

  UserData._();

  int get id;

  String get updatedOn;

  String get createdOn;

  String get firstName;

  String get lastName;

  String? get email;

  String? get phoneNumber;

  String? get jobTitle;

  String? get linkedInUsername;

  String? get twitterUsername;

  String? get facebookUsername;

  String? get skypeUsername;

  String? get profilePicture;

  String? get bio;

  int? get organizationId;

  int get eventId;

  JsonObject get customFieldsValues;

  // run time columns
  String get emailInvitationStatus;

  // custom fields
  bool? get isByTemporaryPassword;

  String? get qrCode;

  String? get authorization;

  OrganizationData? get organization;

  BuiltList<GroupData>? get groups;

  BuiltList<CustomColumnData>? get columns;

  BuiltList<CustomFieldData>? get formattedCustomFieldsValues;

  MeetingData? get meeting;

  // from joining
  String? get sessionName;

  int? get unreadMessagesCount;

  String? get lastMessage;

  DateTime? get lastMessageCreatedOn;

  BuiltList<SessionData>? get sessions;

  String? get note;

  UserPermissionData? get permissions;

  // custom made
  bool? get isOnline;

  String get fullName => '$firstName $lastName';

  String get initials =>
      '${firstName.substring(0, 1)}${lastName.substring(0, 1)}'.toUpperCase();

  String? get jobAtOrganization => jobTitle == null && organization == null
      ? null
      : '${jobTitle ?? ''}${jobTitle == null || organization == null ? '' : ' at '}${organization?.name ?? ''}';

  static Serializer<UserData> get serializer => _$userDataSerializer;

  static UserData fromDynamic(final dynamic json) {
    return serializers.deserializeWith(UserData.serializer, json)!;
  }

  static BuiltList<UserData> fromDynamics(final dynamic json) {
    final list = json as List<dynamic>;
    return BuiltList(list.map((final obj) => UserData.fromDynamic(obj)));
  }

  dynamic toDynamic() {
    return serializers.serializeWith(UserData.serializer, this);
  }
}
