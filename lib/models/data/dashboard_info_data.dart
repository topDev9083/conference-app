import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import '../serializers.dart';
import 'meeting_data.dart';
import 'session_data.dart';
import 'user_data.dart';

part 'dashboard_info_data.g.dart';

abstract class DashboardInfoData
    implements Built<DashboardInfoData, DashboardInfoDataBuilder> {
  factory DashboardInfoData([
    final void Function(DashboardInfoDataBuilder) updates,
  ]) = _$DashboardInfoData;

  DashboardInfoData._();

  static Serializer<DashboardInfoData> get serializer =>
      _$dashboardInfoDataSerializer;

  static void _initializeBuilder(final DashboardInfoDataBuilder b) => b;

  BuiltList<MeetingData> get acceptedMeetings;

  BuiltList<MeetingData> get pendingMeetingRequests;

  BuiltList<SessionData> get sessions;

  BuiltList<UserData> get speakers;

  BuiltList<UserData> get users;

  static DashboardInfoData fromDynamic(final dynamic json) {
    return serializers.deserializeWith(DashboardInfoData.serializer, json)!;
  }

  static BuiltList<DashboardInfoData> fromDynamics(final List<dynamic> list) {
    return BuiltList<DashboardInfoData>(
      list.map(
        (final json) => fromDynamic(json),
      ),
    );
  }
}
