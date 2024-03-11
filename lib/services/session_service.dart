import 'package:built_collection/built_collection.dart';

import '../models/data/role_data.dart';
import '../models/data/session_data.dart';
import '../models/response/api_response.dart';
import '../utils/dio.dart';

class _SessionService {
  BuiltList<SessionData> pipeSessions(final BuiltList<SessionData> sessions) {
    final ListBuilder<SessionData> updatedSessions = ListBuilder();
    for (final session in sessions) {
      final sessionB = session.toBuilder();
      sessionB.roles = ListBuilder();
      for (final ur in session.userRoles!) {
        final roleIndex =
            sessionB.roles.build().indexWhere((final r) => r.id == ur.roleId);
        RoleDataBuilder role;
        if (roleIndex == -1) {
          role = ur.role!.toBuilder();
        } else {
          role = sessionB.roles[roleIndex].toBuilder();
        }
        role.users.add(ur.user!);
        if (roleIndex != -1) {
          sessionB.roles.removeAt(roleIndex);
          sessionB.roles.insert(roleIndex, role.build());
        } else {
          sessionB.roles.add(role.build());
        }
      }
      updatedSessions.add(sessionB.build());
    }
    return updatedSessions.build();
  }

  Future<BuiltList<SessionData>> getSessions({
    final int? startDateTimeOfStartDate,
    final int? endDateTimeOfStartDate,
    final CancelToken? cancelToken,
  }) async {
    final response = await dio.get(
      'sessions',
      queryParameters: {
        'startDateTimeOfStartDate': startDateTimeOfStartDate,
        'endDateTimeOfStartDate': endDateTimeOfStartDate,
      }..removeWhere((final key, final value) => value == null),
      cancelToken: cancelToken,
    );
    final sessions = SessionData.fromDynamics(
      ApiResponse(response.data).data as List<dynamic>,
    );
    return pipeSessions(sessions);
  }

  Future<SessionData> addSessionToAgenda(final int sessionId) async {
    final response = await dio.post('sessions/$sessionId/session-users');
    final session = SessionData.fromDynamic(ApiResponse(response.data).data);
    return pipeSessions(BuiltList([session]))[0];
  }

  Future<SessionData> removeSessionToAgenda(final int sessionId) async {
    final response = await dio.delete('sessions/$sessionId/session-users');
    final session = SessionData.fromDynamic(ApiResponse(response.data).data);
    return pipeSessions(BuiltList([session]))[0];
  }
}

final sessionService = _SessionService();
