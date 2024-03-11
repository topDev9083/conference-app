import 'package:built_value/built_value.dart';
import 'package:flutter/material.dart' as material;

import '../../../models/data/user_occupancy_data.dart';
import '../../../models/states/api_state.dart';

part 'add_user_occupancy_state.g.dart';

abstract class AddUserOccupancyState
    implements Built<AddUserOccupancyState, AddUserOccupancyStateBuilder> {
  factory AddUserOccupancyState([
    final void Function(AddUserOccupancyStateBuilder) updates,
  ]) = _$AddUserOccupancyState;

  AddUserOccupancyState._();

  static void _initializeBuilder(final AddUserOccupancyStateBuilder b) =>
      b..reason = '';

  DateTime? get date;

  material.TimeOfDay? get startTime;

  material.TimeOfDay? get endTime;

  String get reason;

  ApiState<UserOccupancyData> get addUserOccupancyApi;
}
