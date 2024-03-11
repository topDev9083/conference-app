import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import '../enums/agenda_combined_type.dart';
import '../serializers.dart';
import 'meeting_data.dart';
import 'session_data.dart';
import 'user_occupancy_data.dart';

part 'agenda_combined_data.g.dart';

abstract class AgendaCombinedData
    implements Built<AgendaCombinedData, AgendaCombinedDataBuilder> {
  factory AgendaCombinedData([
    final void Function(AgendaCombinedDataBuilder) updates,
  ]) = _$AgendaCombinedData;

  AgendaCombinedData._();

  static Serializer<AgendaCombinedData> get serializer =>
      _$agendaCombinedDataSerializer;

  static void _initializeBuilder(final AgendaCombinedDataBuilder b) => b;

  AgendaCombinedType get type;

  MeetingData? get meeting;

  SessionData? get session;

  UserOccupancyData? get occupancy;

  DateTime get date;

  static AgendaCombinedData fromDynamic(final dynamic json) {
    return serializers.deserializeWith(AgendaCombinedData.serializer, json)!;
  }

  static BuiltList<AgendaCombinedData> fromDynamics(final List<dynamic> list) {
    return BuiltList<AgendaCombinedData>(
      list.map(
        (final json) => fromDynamic(json),
      ),
    );
  }
}
