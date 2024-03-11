import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import '../serializers.dart';
import 'meeting_data.dart';
import 'session_data.dart';
import 'user_occupancy_data.dart';

part 'agenda_data.g.dart';

abstract class AgendaData implements Built<AgendaData, AgendaDataBuilder> {
  factory AgendaData([final void Function(AgendaDataBuilder) updates]) =
      _$AgendaData;

  AgendaData._();

  static Serializer<AgendaData> get serializer => _$agendaDataSerializer;

  static void _initializeBuilder(final AgendaDataBuilder b) => b;

  BuiltList<MeetingData> get meetings;

  BuiltList<SessionData> get sessions;

  BuiltList<UserOccupancyData> get occupancies;

  static AgendaData fromDynamic(final dynamic json) {
    return serializers.deserializeWith(AgendaData.serializer, json)!;
  }
}
