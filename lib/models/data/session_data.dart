import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import '../serializers.dart';
import 'map_location_data.dart';
import 'role_data.dart';
import 'session_user_data.dart';
import 'track_data.dart';

part 'session_data.g.dart';

abstract class SessionData implements Built<SessionData, SessionDataBuilder> {
  factory SessionData([final void Function(SessionDataBuilder) updates]) =
      _$SessionData;

  SessionData._();

  static Serializer<SessionData> get serializer => _$sessionDataSerializer;

  static void _initializeBuilder(final SessionDataBuilder b) => b;

  int get id;

  DateTime get updatedOn;

  DateTime get createdOn;

  String get name;

  String get description;

  DateTime get startDate;

  DateTime get endDate;

  String? get locationName;

  int? get mapLocationId;

  // custom fields
  BuiltList<TrackData>? get tracks;

  BuiltList<SessionUserData>? get userRoles;

  MapLocationData? get mapLocation;

  int? get userId;

  // self created
  BuiltList<RoleData>? get roles;

  // from sub query
  bool? get isInMyAgenda;

  BuiltList<TrackData> getTracksIncludingNestedTracks() {
    final tracks = ListBuilder<TrackData>();
    for (final track in this.tracks ?? BuiltList<TrackData>()) {
      tracks.add(track);
      for (final subTrack in track.subTracks ?? BuiltList<TrackData>()) {
        tracks.add(subTrack);
      }
    }
    return tracks.build();
  }

  static SessionData fromDynamic(final dynamic json) {
    return serializers.deserializeWith(SessionData.serializer, json)!;
  }

  static BuiltList<SessionData> fromDynamics(final List<dynamic> list) {
    return BuiltList<SessionData>(list.map((final json) => fromDynamic(json)));
  }
}
