import 'package:built_value/built_value.dart';

import '../../../../../models/data/session_data.dart';
import '../../../../../models/states/api_state.dart';

part 'session_detail_state.g.dart';

abstract class SessionDetailState
    implements Built<SessionDetailState, SessionDetailStateBuilder> {
  factory SessionDetailState([
    final void Function(SessionDetailStateBuilder) updates,
  ]) = _$SessionDetailState;

  SessionDetailState._();

  static void _initializeBuilder(final SessionDetailStateBuilder b) => b;

  SessionData get session;

  ApiState<SessionData> get addToAgendaApi;
}
