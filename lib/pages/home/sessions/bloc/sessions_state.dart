import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';

import '../../../../models/data/session_data.dart';
import '../../../../models/states/api_state.dart';

part 'sessions_state.g.dart';

abstract class SessionsState
    implements Built<SessionsState, SessionsStateBuilder> {
  factory SessionsState([
    final void Function(SessionsStateBuilder) updates,
  ]) = _$SessionsState;

  SessionsState._();

  static void _initializeBuilder(final SessionsStateBuilder b) => b;

  ApiState<BuiltList<SessionData>> get sessionsApi;

  DateTime? get startDateTimeOfStartDate;

  DateTime? get endDateTimeOfStartDate;

  BuiltMap<int, ApiState<void>> get addToAgendaApi;
}
