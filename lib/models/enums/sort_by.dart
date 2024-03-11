// ignore_for_file: prefer_final_parameters

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'sort_by.g.dart';

class SortBy extends EnumClass {
  static Serializer<SortBy> get serializer => _$sortBySerializer;

  static BuiltSet<SortBy> get values => _$values;

  static SortBy valueOf(String name) => _$valueOf(name);

  @BuiltValueEnumConst(wireName: 'name')
  static const SortBy namee = _$name;
  static const SortBy jobTitle = _$jobTitle;
  static const SortBy organizationName = _$organizationName;
  static const SortBy createdOn = _$createdOn;

  const SortBy._(String name) : super(name);
}
