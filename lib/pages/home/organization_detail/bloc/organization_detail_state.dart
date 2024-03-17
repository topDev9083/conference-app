import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';

import '../../../../models/data/organization_data.dart';
import '../../../../models/data/user_data.dart';
import '../../../../models/states/api_state.dart';

part 'organization_detail_state.g.dart';

abstract class OrganizationDetailState
    implements Built<OrganizationDetailState, OrganizationDetailStateBuilder> {
  factory OrganizationDetailState([
    final void Function(OrganizationDetailStateBuilder) updates,
  ]) = _$OrganizationDetailState;

  OrganizationDetailState._();

  static void _initializeBuilder(final OrganizationDetailStateBuilder b) => b;

  String? get boothNumber;

  OrganizationData get organization;

  ApiState<BuiltList<UserData>> get getColleaguesApi;
}
