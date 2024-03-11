import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import '../serializers.dart';
import 'organization_data.dart';
import 'sponsorship_level_data.dart';

part 'sponsor_data.g.dart';

abstract class SponsorData implements Built<SponsorData, SponsorDataBuilder> {
  factory SponsorData([final void Function(SponsorDataBuilder) updates]) =
      _$SponsorData;

  SponsorData._();

  static Serializer<SponsorData> get serializer => _$sponsorDataSerializer;

  static void _initializeBuilder(final SponsorDataBuilder b) => b;

  int get id;

  String get updatedOn;

  String get createdOn;

  String? get boothNumber;

  int? get sponsorshipLevelId;

  int get organizationId;

  // custom fields
  OrganizationData? get organization;

  SponsorshipLevelData? get sponsorshipLevel;

  static SponsorData fromDynamic(final dynamic json) {
    return serializers.deserializeWith(SponsorData.serializer, json)!;
  }

  static BuiltList<SponsorData> fromDynamics(final List<dynamic> list) {
    return BuiltList<SponsorData>(list.map((final json) => fromDynamic(json)));
  }
}
