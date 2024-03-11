import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/serializer.dart';

import '../enums/custom_field_type.dart';
import '../serializers.dart';

part 'custom_field_data.g.dart';

abstract class CustomFieldData
    implements Built<CustomFieldData, CustomFieldDataBuilder> {
  factory CustomFieldData([
    final void Function(CustomFieldDataBuilder) updates,
  ]) = _$CustomFieldData;

  CustomFieldData._();

  static Serializer<CustomFieldData> get serializer =>
      _$customFieldDataSerializer;

  static void _initializeBuilder(final CustomFieldDataBuilder b) => b;

  int get id;

  String get updatedOn;

  String get createdOn;

  CustomFieldType get type;

  String get name;

  int get priority;

  int? get parentId;

  // custom fields
  BuiltList<CustomFieldData>? get children;

  JsonObject? get value; // boolean | string | number | null

  static CustomFieldData fromDynamic(final dynamic json) {
    return serializers.deserializeWith(CustomFieldData.serializer, json)!;
  }

  static BuiltList<CustomFieldData> fromDynamics(final List<dynamic> list) {
    return BuiltList<CustomFieldData>(
      list.map(
        (final json) => fromDynamic(json),
      ),
    );
  }
}
