import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import '../serializers.dart';
import 'organization_data.dart';

part 'exhibitor_data.g.dart';

abstract class ExhibitorData
    implements Built<ExhibitorData, ExhibitorDataBuilder> {
  factory ExhibitorData([final void Function(ExhibitorDataBuilder) updates]) =
      _$ExhibitorData;

  ExhibitorData._();

  static Serializer<ExhibitorData> get serializer => _$exhibitorDataSerializer;

  static void _initializeBuilder(final ExhibitorDataBuilder b) => b;

  int get id;

  String get updatedOn;

  String get createdOn;

  String? get boothNumber;

  int get organizationId;

  // custom fields
  OrganizationData? get organization;

  static ExhibitorData fromDynamic(final dynamic json) {
    return serializers.deserializeWith(ExhibitorData.serializer, json)!;
  }

  static BuiltList<ExhibitorData> fromDynamics(final List<dynamic> list) {
    return BuiltList(list.map((final json) => fromDynamic(json)));
  }
}
