import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import '../serializers.dart';

part 'schedule_data.g.dart';

abstract class ScheduleData
    implements Built<ScheduleData, ScheduleDataBuilder> {
  factory ScheduleData([final void Function(ScheduleDataBuilder) updates]) =
      _$ScheduleData;

  ScheduleData._();

  static Serializer<ScheduleData> get serializer => _$scheduleDataSerializer;

  static void _initializeBuilder(final ScheduleDataBuilder b) => b;

  int get id;

  String get updatedOn;

  String get createdOn;

  String get name;

  static ScheduleData fromDynamic(final dynamic json) {
    return serializers.deserializeWith(ScheduleData.serializer, json)!;
  }
}
