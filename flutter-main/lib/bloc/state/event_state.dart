import 'package:built_value/built_value.dart';

import '../../models/data/event_data.dart';
import '../../models/states/api_state.dart';

part 'event_state.g.dart';

abstract class EventState implements Built<EventState, EventStateBuilder> {
  factory EventState([
    final void Function(EventStateBuilder) updates,
  ]) = _$EventState;

  EventState._();

  @BuiltValueHook(initializeBuilder: true)
  static void _initialize(final EventStateBuilder b) => b;

  ApiState<EventData> get getEventApi;
}
