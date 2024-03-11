import 'package:built_value/built_value.dart';
import 'package:flutter/widgets.dart' show Widget;

import '../../models/states/api_state.dart';

part 'home_drawer_state.g.dart';

abstract class HomeDrawerState
    implements Built<HomeDrawerState, HomeDrawerStateBuilder> {
  factory HomeDrawerState([
    final void Function(HomeDrawerStateBuilder) updates,
  ]) = _$HomeDrawerState;

  HomeDrawerState._();

  @BuiltValueHook(initializeBuilder: true)
  static void _initialize(final HomeDrawerStateBuilder b) => b
    ..isDesktopDrawerCollapsed = false
    ..unreadMessageCountApi.data = 0;

  bool get isDesktopDrawerCollapsed;

  Widget? get endDrawer;

  ApiState<int> get unreadMessageCountApi;
}
