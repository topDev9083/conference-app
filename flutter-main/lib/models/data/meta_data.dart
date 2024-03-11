import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import '../serializers.dart';

part 'meta_data.g.dart';

abstract class MetaData implements Built<MetaData, MetaDataBuilder> {
  factory MetaData([final void Function(MetaDataBuilder) updates]) = _$MetaData;

  MetaData._();

  int get status;

  String get message;

  String get key;

  static MetaData fromDynamic(final dynamic json) {
    return serializers.deserializeWith(MetaData.serializer, json)!;
  }

  static Serializer<MetaData> get serializer => _$metaDataSerializer;

  @override
  String toString() {
    return message;
  }
}
