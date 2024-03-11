// ignore_for_file: prefer_final_parameters

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'custom_field_type.g.dart';

class CustomFieldType extends EnumClass {
  static Serializer<CustomFieldType> get serializer =>
      _$customFieldTypeSerializer;

  static BuiltSet<CustomFieldType> get values => _$values;

  static CustomFieldType valueOf(String name) => _$valueOf(name);

  static const CustomFieldType textFieldNumber = _$textFieldNumber;
  static const CustomFieldType textFieldString = _$textFieldString;
  static const CustomFieldType checkboxSingle = _$checkboxSingle;
  static const CustomFieldType groupOption = _$groupOption;
  static const CustomFieldType checkboxGroup = _$checkboxGroup;
  static const CustomFieldType radioGroup = _$radioGroup;

  const CustomFieldType._(String name) : super(name);
}
