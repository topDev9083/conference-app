import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';

import '../../../../models/data/meeting_data.dart';
import '../../../../models/enums/meeting_status.dart';
import '../../../../models/states/api_state.dart';

part 'meeting_management_state.g.dart';

abstract class MeetingManagementState
    implements Built<MeetingManagementState, MeetingManagementStateBuilder> {
  factory MeetingManagementState([
    final void Function(MeetingManagementStateBuilder) updates,
  ]) = _$MeetingManagementState;

  MeetingManagementState._();

  static void _initializeBuilder(final MeetingManagementStateBuilder b) => b;

  ApiState<BuiltList<MeetingData>> get getMeetingsApi;

  BuiltList<MeetingData>? get filteredMeetings;

  MeetingStatus? get selectedMeetingStatus;
}
