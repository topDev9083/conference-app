// ignore_for_file: prefer_final_parameters

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'environments.g.dart';

class Environments extends EnumClass {
  static Serializer<Environments> get serializer => _$environmentsSerializer;

  static BuiltSet<Environments> get values => _$values;

  static Environments valueOf(String name) => _$valueOf(name);

  static const Environments localhost = _$localhost;
  @BuiltValueEnumConst(fallback: true)
  static const Environments stage = _$stage;
  static const Environments production = _$production;

  const Environments._(String name) : super(name);
}
