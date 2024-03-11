import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import '../serializers.dart';

part 'user_occupancy_data.g.dart';

abstract class UserOccupancyData
    implements Built<UserOccupancyData, UserOccupancyDataBuilder> {
  factory UserOccupancyData([
    final void Function(UserOccupancyDataBuilder) updates,
  ]) = _$UserOccupancyData;

  UserOccupancyData._();

  static Serializer<UserOccupancyData> get serializer =>
      _$userOccupancyDataSerializer;

  static void _initializeBuilder(final UserOccupancyDataBuilder b) => b;

  int get id;

  DateTime get updatedOn;

  DateTime get createdOn;

  int get userId;

  DateTime get startDate;

  DateTime get endDate;

  String? get reason;

  static UserOccupancyData fromDynamic(final dynamic json) {
    return serializers.deserializeWith(UserOccupancyData.serializer, json)!;
  }

  static BuiltList<UserOccupancyData> fromDynamics(final List<dynamic> list) {
    return BuiltList<UserOccupancyData>(
      list.map((final json) => fromDynamic(json)),
    );
  }
}
