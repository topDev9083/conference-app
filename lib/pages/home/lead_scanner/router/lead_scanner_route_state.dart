import 'package:built_value/built_value.dart';

import 'lead_scanner_route_delegate.dart';

part 'lead_scanner_route_state.g.dart';

abstract class LeadScannerRouteState
    implements Built<LeadScannerRouteState, LeadScannerRouteStateBuilder> {
  factory LeadScannerRouteState([
    final void Function(LeadScannerRouteStateBuilder) updates,
  ]) = _$LeadScannerRouteState;

  LeadScannerRouteState._();

  @BuiltValueHook(initializeBuilder: true)
  static void _initialize(final LeadScannerRouteStateBuilder b) =>
      b..routeDelegate = LeadScannerRouteDelegate();

  LeadScannerRouteDelegate get routeDelegate;
}
