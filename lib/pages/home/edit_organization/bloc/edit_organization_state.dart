import 'package:built_value/built_value.dart';
import 'package:file_picker/file_picker.dart';

import '../../../../models/data/organization_data.dart';
import '../../../../models/states/api_state.dart';

part 'edit_organization_state.g.dart';

abstract class EditOrganizationState
    implements Built<EditOrganizationState, EditOrganizationStateBuilder> {
  factory EditOrganizationState([
    final void Function(EditOrganizationStateBuilder) updates,
  ]) = _$EditOrganizationState;

  EditOrganizationState._();

  @BuiltValueHook(initializeBuilder: true)
  static void _initialize(final EditOrganizationStateBuilder b) => b;

  OrganizationData get organization;

  PlatformFile? get logo;

  ApiState<OrganizationData> get updateOrganizationApi;
}
