import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';

import '../../../../../models/data/grouped_time_slots_data.dart';
import '../../../../../models/data/time_slot_data.dart';
import '../../../../../models/data/user_data.dart';
import '../../../../../models/states/api_state.dart';

part 'schedule_meeting_detail_state.g.dart';

abstract class ScheduleMeetingDetailState
    implements
        Built<ScheduleMeetingDetailState, ScheduleMeetingDetailStateBuilder> {
  factory ScheduleMeetingDetailState([
    final void Function(ScheduleMeetingDetailStateBuilder) updates,
  ]) = _$ScheduleMeetingDetailState;

  ScheduleMeetingDetailState._();

  static void _initializeBuilder(final ScheduleMeetingDetailStateBuilder b) =>
      b..meetingRequestMessage = '';

  int get userId;

  ApiState<UserData> get userApi;

  ApiState<BuiltList<UserData>> get colleaguesApi;

  ApiState<BuiltList<TimeSlotData>> get timeSlotsApi;

  BuiltList<GroupedTimeSlotsData>? get groupedTimeSlots;

  BuiltSet<int> get selectedTimeSlotIds;

  String get meetingRequestMessage;

  ApiState<void> get meetingRequestApi;

  ApiState<void> get updateNoteApi;
}
