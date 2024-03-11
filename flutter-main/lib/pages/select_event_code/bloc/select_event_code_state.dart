import 'package:built_value/built_value.dart';
import 'package:flutter/material.dart' show FocusNode;

import '../../../models/data/event_data.dart';
import '../../../models/states/api_state.dart';
import '../../../others/constants.dart';

part 'select_event_code_state.g.dart';

abstract class SelectEventCodeState
    implements Built<SelectEventCodeState, SelectEventCodeStateBuilder> {
  factory SelectEventCodeState([
    final void Function(SelectEventCodeStateBuilder) updates,
  ]) = _$SelectEventCodeState;

  SelectEventCodeState._();

  @BuiltValueHook(initializeBuilder: true)
  static void _initialize(final SelectEventCodeStateBuilder b) => b
    ..eventCode = ''
    ..eventCodeFocusNode = FocusNode();

  @BuiltValueHook(finalizeBuilder: true)
  static void _finalize(final SelectEventCodeStateBuilder b) {
    final eventCodeRegex = RegExp(Constants.REGEX_SUBDOMAIN);
    b.isEventCodeValid = eventCodeRegex.hasMatch(b.eventCode ?? '');
  }

  String get eventCode;

  // finalize
  bool get isEventCodeValid;

  FocusNode get eventCodeFocusNode;

  ApiState<EventData> get getEventApi;
}
