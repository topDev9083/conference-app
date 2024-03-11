import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import '../serializers.dart';

part 'custom_column_data.g.dart';

abstract class CustomColumnData
    implements Built<CustomColumnData, CustomColumnDataBuilder> {
  factory CustomColumnData([
    final void Function(CustomColumnDataBuilder) updates,
  ]) = _$CustomColumnData;

  CustomColumnData._();

  static Serializer<CustomColumnData> get serializer =>
      _$customColumnDataSerializer;

  static void _initializeBuilder(final CustomColumnDataBuilder b) => b;

  String get name;

  String? get value;

  static CustomColumnData fromDynamic(final dynamic json) {
    return serializers.deserializeWith(CustomColumnData.serializer, json)!;
  }
}
