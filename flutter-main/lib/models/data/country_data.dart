import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import '../serializers.dart';

part 'country_data.g.dart';

abstract class CountryData implements Built<CountryData, CountryDataBuilder> {
  factory CountryData([final void Function(CountryDataBuilder) updates]) =
      _$CountryData;

  CountryData._();

  static Serializer<CountryData> get serializer => _$countryDataSerializer;

  static void _initializeBuilder(final CountryDataBuilder b) => b;

  int get id;

  String get updatedOn;

  String get createdOn;

  String get name;

  String get code;

  //from joining
  int? get usersCount;

  static CountryData fromDynamic(final dynamic json) {
    return serializers.deserializeWith(CountryData.serializer, json)!;
  }

  static BuiltList<CountryData> fromDynamics(final dynamic json) {
    final list = json as List<dynamic>;
    return BuiltList<CountryData>(
      list.map((final obj) => CountryData.fromDynamic(obj)),
    );
  }
}
