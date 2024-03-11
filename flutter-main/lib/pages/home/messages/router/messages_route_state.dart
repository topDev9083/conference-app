import 'package:built_value/built_value.dart';

import 'messages_route_delegate.dart';

part 'messages_route_state.g.dart';

abstract class MessagesRouteState
    implements Built<MessagesRouteState, MessagesRouteStateBuilder> {
  factory MessagesRouteState([
    final void Function(MessagesRouteStateBuilder) updates,
  ]) = _$MessagesRouteState;

  MessagesRouteState._();

  @BuiltValueHook(initializeBuilder: true)
  static void _initialize(final MessagesRouteStateBuilder b) =>
      b..routeDelegate = MessagesRouteDelegate();

  MessagesRouteDelegate get routeDelegate;
}
