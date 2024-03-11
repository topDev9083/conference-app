import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/json_object.dart';
import 'package:file_picker/file_picker.dart';

import '../../../../models/data/custom_field_data.dart';
import '../../../../models/data/user_data.dart';
import '../../../../models/states/api_state.dart';

part 'edit_profile_state.g.dart';

abstract class EditProfileState
    implements Built<EditProfileState, EditProfileStateBuilder> {
  factory EditProfileState([
    final void Function(EditProfileStateBuilder) updates,
  ]) = _$EditProfileState;

  EditProfileState._();

  static void _initializeBuilder(final EditProfileStateBuilder b) => b;

  ApiState<BuiltList<CustomFieldData>> get getCustomFieldsApi;

  ApiState<UserData> get updateProfileApi;

  ApiState<BuiltList<UserData>> get getColleaguesApi;

  // profile fields
  String? get firstName;

  String? get lastName;

  String? get phoneNumber;

  String? get jobTitle;

  String? get bio;

  JsonObject get customFieldsValues;

  PlatformFile? get profilePicture;

  String? get linkedInUsername;

  String? get twitterUsername;

  String? get facebookUsername;

  String? get skypeUsername;
}
