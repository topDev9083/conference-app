import 'package:built_collection/built_collection.dart';

import '../models/data/meeting_data.dart';
import '../models/enums/meeting_status.dart';
import '../models/response/api_response.dart';
import '../utils/dio.dart';

class _MeetingService {
  Future<MeetingData> createMeeting({
    required final int toUserId,
    required final BuiltSet<int> timeSlotIds,
    final String? message,
  }) async {
    final response = await dio.post(
      'meetings',
      data: {
        'toUserId': toUserId,
        'timeSlotIds': timeSlotIds.toList(),
        if (message != null && message.trim().isNotEmpty) 'message': message,
      },
    );
    return MeetingData.fromDynamic(ApiResponse(response.data).data);
  }

  Future<MeetingData> updateMeetingById({
    required final int meetingId,
    required final MeetingStatus status,
    final BuiltSet<int>? timeSlotIds,
    final String? message,
  }) async {
    final response = await dio.put(
      'meetings/$meetingId',
      data: {
        'status': status.toString(),
        if (timeSlotIds != null) 'timeSlotIds': timeSlotIds.toList(),
        if (message != null && message.trim().isNotEmpty) 'message': message,
      },
    );
    return MeetingData.fromDynamic(ApiResponse(response.data).data);
  }

  Future<BuiltList<MeetingData>> getMyMeetings() async {
    final response = await dio.get('meetings');
    return MeetingData.fromDynamics(
      ApiResponse(response.data).data as List<dynamic>,
    );
  }
}

final meetingService = _MeetingService();
