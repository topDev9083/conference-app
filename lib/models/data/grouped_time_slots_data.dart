import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import '../../extensions/date_time.dart';
import 'time_slot_data.dart';

part 'grouped_time_slots_data.g.dart';

abstract class GroupedTimeSlotsData
    implements Built<GroupedTimeSlotsData, GroupedTimeSlotsDataBuilder> {
  factory GroupedTimeSlotsData([
    final void Function(GroupedTimeSlotsDataBuilder) updates,
  ]) = _$GroupedTimeSlotsData;

  GroupedTimeSlotsData._();

  static Serializer<GroupedTimeSlotsData> get serializer =>
      _$groupedTimeSlotsDataSerializer;

  static void _initializeBuilder(final GroupedTimeSlotsDataBuilder b) => b;

  DateTime get headerDate;

  BuiltList<TimeSlotData> get timeSlots;

  static BuiltList<GroupedTimeSlotsData> fromTimeSlots(
    final BuiltList<TimeSlotData> timeSlots, {
    required final String zone,
  }) {
    final groupedTimeSlots = <GroupedTimeSlotsDataBuilder>[];
    timeSlots.asMap().forEach((final index, final ts) {
      if (index == 0 ||
          !groupedTimeSlots.last.headerDate!.isAtSameDateAs(
            ts.startDate,
            zone: zone,
          )) {
        groupedTimeSlots.add(
          GroupedTimeSlotsDataBuilder()
            ..headerDate = ts.startDate
            ..timeSlots = ListBuilder([ts]),
        );
      } else {
        groupedTimeSlots.last.timeSlots.add(ts);
      }
    });
    return BuiltList(groupedTimeSlots.map((final gtsB) => gtsB.build()));
  }
}
