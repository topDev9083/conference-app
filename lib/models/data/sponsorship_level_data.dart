import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import '../serializers.dart';

part 'sponsorship_level_data.g.dart';

abstract class SponsorshipLevelData
    implements Built<SponsorshipLevelData, SponsorshipLevelDataBuilder> {
  factory SponsorshipLevelData([
    final void Function(SponsorshipLevelDataBuilder) updates,
  ]) = _$SponsorshipLevelData;

  SponsorshipLevelData._();

  static Serializer<SponsorshipLevelData> get serializer =>
      _$sponsorshipLevelDataSerializer;

  static void _initializeBuilder(final SponsorshipLevelDataBuilder b) => b;

  int get id;

  String get updatedOn;

  String get createdOn;

  String get name;

  bool get isReadonly;

  static SponsorshipLevelData fromDynamic(final dynamic json) {
    return serializers.deserializeWith(SponsorshipLevelData.serializer, json)!;
  }
}
