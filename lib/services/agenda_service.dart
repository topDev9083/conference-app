import '../models/data/agenda_data.dart';
import '../models/response/api_response.dart';
import '../utils/dio.dart';
import 'session_service.dart';

class _AgendaService {
  Future<AgendaData> getMyAgenda({
    final int? startDateTimeOfStartDate,
    final int? endDateTimeOfStartDate,
    final CancelToken? cancelToken,
  }) async {
    final response = await dio.get(
      'agendas',
      queryParameters: {
        'startDateTimeOfStartDate': startDateTimeOfStartDate,
        'endDateTimeOfStartDate': endDateTimeOfStartDate,
      }..removeWhere((final key, final value) => value == null),
      cancelToken: cancelToken,
    );
    final agenda = AgendaData.fromDynamic(ApiResponse(response.data).data);
    return agenda.rebuild(
      (final b) =>
          b..sessions.replace(sessionService.pipeSessions(agenda.sessions)),
    );
  }
}

final agendaService = _AgendaService();
