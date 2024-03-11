import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import '../serializers.dart';
import 'map_data.dart';

part 'map_location_data.g.dart';

abstract class MapLocationData
    implements Built<MapLocationData, MapLocationDataBuilder> {
  factory MapLocationData([
    final void Function(MapLocationDataBuilder) updates,
  ]) = _$MapLocationData;

  MapLocationData._();

  static Serializer<MapLocationData> get serializer =>
      _$mapLocationDataSerializer;

  static void _initializeBuilder(final MapLocationDataBuilder b) => b;

  int get id;

  String get updatedOn;

  String get createdOn;

  String get name;

  double get offsetX;

  double get offsetY;

  int get mapId;

  // custom fields
  MapData? get map;

  static MapLocationData fromDynamic(final dynamic json) {
    return serializers.deserializeWith(MapLocationData.serializer, json)!;
  }
}
