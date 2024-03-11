import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import '../serializers.dart';

part 'time_slot_data.g.dart';

abstract class TimeSlotData
    implements Built<TimeSlotData, TimeSlotDataBuilder> {
  factory TimeSlotData([final void Function(TimeSlotDataBuilder) updates]) =
      _$TimeSlotData;

  TimeSlotData._();

  static Serializer<TimeSlotData> get serializer => _$timeSlotDataSerializer;

  static void _initializeBuilder(final TimeSlotDataBuilder b) => b;

  int get id;

  DateTime get updatedOn;

  DateTime get createdOn;

  DateTime get startDate;

  DateTime get endDate;

  static TimeSlotData fromDynamic(final dynamic json) {
    return serializers.deserializeWith(TimeSlotData.serializer, json)!;
  }

  static BuiltList<TimeSlotData> fromDynamics(final dynamic json) {
    return BuiltList(
      (json as List<dynamic>).map((final obj) => fromDynamic(obj)),
    );
  }
}
