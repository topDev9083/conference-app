import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import '../serializers.dart';
import 'country_data.dart';

part 'organization_data.g.dart';

abstract class OrganizationData
    implements Built<OrganizationData, OrganizationDataBuilder> {
  factory OrganizationData([
    final void Function(OrganizationDataBuilder) updates,
  ]) = _$OrganizationData;

  OrganizationData._();

  static Serializer<OrganizationData> get serializer =>
      _$organizationDataSerializer;

  static void _initializeBuilder(final OrganizationDataBuilder b) => b;

  int get id;

  String get updatedOn;

  String get createdOn;

  String get name;

  String? get phoneNumber;

  String? get website;

  String? get email;

  String? get address;

  String? get city;

  String? get state;

  String? get zipCode;

  String? get profile;

  int? get countryId;

  String? get logo;

  // run time columns
  int? get usersCount;

  // custom fields
  CountryData? get country;

  String get initials =>
      name.length < 2 ? name.toUpperCase() : name.substring(0, 2).toUpperCase();

  String get cityAndCountry =>
      '${city ?? ''}${city != null && countryId != null ? ', ' : ''}${country?.name ?? ''}';

  static OrganizationData fromDynamic(final dynamic json) {
    return serializers.deserializeWith(OrganizationData.serializer, json)!;
  }

  static BuiltList<OrganizationData> fromDynamics(final dynamic json) {
    final list = json as List<dynamic>;
    return BuiltList<OrganizationData>(
      list.map((final obj) => OrganizationData.fromDynamic(obj)),
    );
  }
}
