import 'package:built_value/built_value.dart';

import 'schedule_meetings_route_delegate.dart';

part 'schedule_meetings_route_state.g.dart';

abstract class ScheduleMeetingsRouteState
    implements
        Built<ScheduleMeetingsRouteState, ScheduleMeetingsRouteStateBuilder> {
  factory ScheduleMeetingsRouteState([
    final void Function(ScheduleMeetingsRouteStateBuilder) updates,
  ]) = _$ScheduleMeetingsRouteState;

  ScheduleMeetingsRouteState._();

  @BuiltValueHook(initializeBuilder: true)
  static void _initialize(final ScheduleMeetingsRouteStateBuilder b) =>
      b..routeDelegate = ScheduleMeetingsRouteDelegate();

  ScheduleMeetingsRouteDelegate get routeDelegate;
}
