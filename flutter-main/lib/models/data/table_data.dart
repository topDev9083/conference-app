import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import '../enums/table_type.dart';
import '../serializers.dart';
import 'map_location_data.dart';
import 'schedule_data.dart';
import 'user_data.dart';

part 'table_data.g.dart';

abstract class TableData implements Built<TableData, TableDataBuilder> {
  factory TableData([final void Function(TableDataBuilder) updates]) =
      _$TableData;

  TableData._();

  static Serializer<TableData> get serializer => _$tableDataSerializer;

  static void _initializeBuilder(final TableDataBuilder b) => b;

  int get id;

  String get updatedOn;

  String get createdOn;

  String get name;

  TableType get type;

  int get scheduleId;

  int? get mapLocationId;

  bool get isActive;

  // custom fields
  ScheduleData? get schedule;

  MapLocationData? get mapLocation;

  UserData? get users;

  static TableData fromDynamic(final dynamic json) {
    return serializers.deserializeWith(TableData.serializer, json)!;
  }
}
