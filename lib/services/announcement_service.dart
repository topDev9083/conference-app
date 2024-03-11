import 'package:built_collection/built_collection.dart';

import '../models/data/announcement_data.dart';
import '../models/response/api_response.dart';
import '../utils/dio.dart';

class _AnnouncementService {
  Future<BuiltList<AnnouncementData>> getAnnouncements() async {
    final response = await dio.get('announcements');
    return AnnouncementData.fromDynamics(
      ApiResponse(response.data).data as List<dynamic>,
    );
  }

  Future<void> markAnnouncementAsRead(final int announcementId) {
    return dio.put('announcements/$announcementId/mark-as-read');
  }

  Future<AnnouncementData> getAnnouncementById(final announcementId) async {
    final response = await dio.get('announcements/$announcementId');
    return AnnouncementData.fromDynamic(ApiResponse(response.data).data);
  }
}

final announcementService = _AnnouncementService();
