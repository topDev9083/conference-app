import 'package:built_value/built_value.dart';

import 'auth_router_delegate.dart';

part 'auth_route_state.g.dart';

abstract class AuthRouteState
    implements Built<AuthRouteState, AuthRouteStateBuilder> {
  factory AuthRouteState([
    final void Function(AuthRouteStateBuilder) updates,
  ]) = _$AuthRouteState;

  AuthRouteState._();

  @BuiltValueHook(initializeBuilder: true)
  static void _initialize(final AuthRouteStateBuilder b) =>
      b..routerDelegate = AuthRouterDelegate();

  AuthRouterDelegate get routerDelegate;
}
