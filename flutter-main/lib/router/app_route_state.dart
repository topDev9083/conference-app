import 'package:built_value/built_value.dart';
import 'package:flutter/material.dart' show RootBackButtonDispatcher;

import 'app_route_config.dart';
import 'app_route_information_parser.dart';
import 'app_router_delegate.dart';

part 'app_route_state.g.dart';

abstract class AppRouteState
    implements Built<AppRouteState, AppRouteStateBuilder> {
  factory AppRouteState([
    final void Function(AppRouteStateBuilder) updates,
  ]) = _$AppRouteState;

  AppRouteState._();

  @BuiltValueHook(initializeBuilder: true)
  static void _initialize(final AppRouteStateBuilder b) => b
    ..routeInformationParser = AppRouteInformationParser()
    ..backButtonDispatcher = RootBackButtonDispatcher();

  AppRouteConfig get routeConfig;

  AppRouterDelegate get routerDelegate;

  AppRouteInformationParser get routeInformationParser;

  RootBackButtonDispatcher get backButtonDispatcher;
}
