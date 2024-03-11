// ignore_for_file: prefer_final_parameters

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'agenda_combined_type.g.dart';

class AgendaCombinedType extends EnumClass {
  static Serializer<AgendaCombinedType> get serializer =>
      _$agendaCombinedTypeSerializer;

  static BuiltSet<AgendaCombinedType> get values => _$values;

  static AgendaCombinedType valueOf(String name) => _$valueOf(name);

  static const AgendaCombinedType meeting = _$meeting;
  static const AgendaCombinedType session = _$session;
  static const AgendaCombinedType occupancy = _$occupancy;
  static const AgendaCombinedType none = _$none;

  const AgendaCombinedType._(String name) : super(name);
}
