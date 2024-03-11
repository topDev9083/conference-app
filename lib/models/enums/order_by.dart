// ignore_for_file: prefer_final_parameters

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'order_by.g.dart';

class OrderBy extends EnumClass {
  static Serializer<OrderBy> get serializer => _$orderBySerializer;

  static BuiltSet<OrderBy> get values => _$values;

  static OrderBy valueOf(String name) => _$valueOf(name);

  static const OrderBy asc = _$asc;
  static const OrderBy desc = _$desc;

  const OrderBy._(String name) : super(name);
}
