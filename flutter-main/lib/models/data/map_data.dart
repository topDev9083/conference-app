import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import '../serializers.dart';

part 'map_data.g.dart';

abstract class MapData implements Built<MapData, MapDataBuilder> {
  factory MapData([final void Function(MapDataBuilder) updates]) = _$MapData;

  MapData._();

  static Serializer<MapData> get serializer => _$mapDataSerializer;

  static void _initializeBuilder(final MapDataBuilder b) => b;

  int get id;

  String get updatedOn;

  String get createdOn;

  String get name;

  String get image;

  static MapData fromDynamic(final dynamic json) {
    return serializers.deserializeWith(MapData.serializer, json)!;
  }
}
