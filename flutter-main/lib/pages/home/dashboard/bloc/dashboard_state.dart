import 'package:built_value/built_value.dart';

import '../../../../models/data/dashboard_info_data.dart';
import '../../../../models/states/api_state.dart';

part 'dashboard_state.g.dart';

abstract class DashboardState
    implements Built<DashboardState, DashboardStateBuilder> {
  factory DashboardState([final void Function(DashboardStateBuilder) updates]) =
      _$DashboardState;

  DashboardState._();

  static void _initializeBuilder(final DashboardStateBuilder b) => b;

  ApiState<DashboardInfoData> get api;
}
