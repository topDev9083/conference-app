// ignore_for_file: prefer_final_parameters

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'table_type.g.dart';

class TableType extends EnumClass {
  static Serializer<TableType> get serializer => _$tableTypeSerializer;

  static BuiltSet<TableType> get values => _$values;

  static TableType valueOf(String name) => _$valueOf(name);

  static const TableType general = _$general;
  static const TableType shared = _$shared;

  const TableType._(String name) : super(name);
}
