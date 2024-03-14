import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';

import '../../../../models/data/user_data.dart';
import '../../../../models/states/api_state.dart';

part 'lead_scanner_state.g.dart';

abstract class LeadScannerState
    implements Built<LeadScannerState, LeadScannerStateBuilder> {
  factory LeadScannerState([
    final void Function(LeadScannerStateBuilder) updates,
  ]) = _$LeadScannerState;

  LeadScannerState._();

  @BuiltValueHook(initializeBuilder: true)
  static void _initialize(final LeadScannerStateBuilder b) => b;

  ApiState<BuiltList<UserData>> get getUsersApi;

  ApiState<UserData> get addUserApi;

  BuiltMap<int, ApiState<void>> get deleteUserApi;

  ApiState<String> get getUsersCsvApi;
}
