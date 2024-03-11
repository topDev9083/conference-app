import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import '../serializers.dart';
import 'app_config_data.dart';
import 'time_zone_data.dart';

part 'event_data.g.dart';

abstract class EventData implements Built<EventData, EventDataBuilder> {
  factory EventData([final void Function(EventDataBuilder) updates]) =
      _$EventData;

  EventData._();

  static Serializer<EventData> get serializer => _$eventDataSerializer;

  static void _initializeBuilder(final EventDataBuilder b) => b;

  int get id;

  DateTime get updatedOn;

  DateTime get createdOn;

  String get name;

  String get code;

  String? get description;

  String? get website;

  DateTime get startDate;

  DateTime get endDate;

  int get timeZoneId;

  bool get is24HourTimeFormat;

  String? get locationName;

  String? get address;

  double? get latitude;

  double? get longitude;

  String get supportEmail;

  String? get sendFromEmail;

  AppConfigData get appConfig;

  // custom fields
  TimeZoneData? get timeZone;

  String? get locationMapUrl {
    if(latitude==null || longitude==null) {
      return null;
    }
    return 'http://maps.google.com/maps?q=loc:$latitude,$longitude';
  }

  static EventData fromDynamic(final dynamic json) {
    return serializers.deserializeWith(EventData.serializer, json)!;
  }

  dynamic toDynamic() {
    return serializers.serializeWith(EventData.serializer, this);
  }
}
