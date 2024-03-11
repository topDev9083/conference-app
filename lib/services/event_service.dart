import '../models/data/event_data.dart';
import '../models/response/api_response.dart';
import '../utils/dio.dart';

class _EventService {
  Future<EventData> getEventByCode(final String code) async {
    final response = await dio.get('events/$code');
    return EventData.fromDynamic(ApiResponse(response.data).data);
  }
}

final eventService = _EventService();
