import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import '../serializers.dart';

part 'track_data.g.dart';

abstract class TrackData implements Built<TrackData, TrackDataBuilder> {
  factory TrackData([final void Function(TrackDataBuilder) updates]) =
      _$TrackData;

  TrackData._();

  static Serializer<TrackData> get serializer => _$trackDataSerializer;

  static void _initializeBuilder(final TrackDataBuilder b) => b;

  int get id;

  String get updatedOn;

  String get createdOn;

  String get name;

  String? get colorHex;

  int get priority;

  int? get parentId;

  //custom fields
  int? get sessionId;

  // from joining
  BuiltList<TrackData>? get subTracks;

  static TrackData fromDynamic(final dynamic json) {
    return serializers.deserializeWith(TrackData.serializer, json)!;
  }
}
