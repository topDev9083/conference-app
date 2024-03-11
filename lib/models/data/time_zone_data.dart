import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import '../serializers.dart';

part 'time_zone_data.g.dart';

abstract class TimeZoneData
    implements Built<TimeZoneData, TimeZoneDataBuilder> {
  factory TimeZoneData([final void Function(TimeZoneDataBuilder) updates]) =
      _$TimeZoneData;

  TimeZoneData._();

  static Serializer<TimeZoneData> get serializer => _$timeZoneDataSerializer;

  static void _initializeBuilder(final TimeZoneDataBuilder b) => b;

  int get id;

  String get updatedOn;

  String get createdOn;

  String get countryName;

  String get countryCode;

  String get zone;

  String get location;

  String get offset;

  static TimeZoneData fromDynamic(final dynamic json) {
    return serializers.deserializeWith(TimeZoneData.serializer, json)!;
  }
}
