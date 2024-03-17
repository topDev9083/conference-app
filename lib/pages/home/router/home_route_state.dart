import 'package:built_value/built_value.dart';

import 'home_router_delegate.dart';

part 'home_route_state.g.dart';

abstract class HomeRouteState
    implements Built<HomeRouteState, HomeRouteStateBuilder> {
  factory HomeRouteState([
    final void Function(HomeRouteStateBuilder) updates,
  ]) = _$HomeRouteState;

  HomeRouteState._();

  @BuiltValueHook(initializeBuilder: true)
  static void _initialize(final HomeRouteStateBuilder b) =>
      b..routerDelegate = HomeRouterDelegate();

  HomeRouterDelegate get routerDelegate;
}
