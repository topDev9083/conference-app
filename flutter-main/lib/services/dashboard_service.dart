import '../models/data/dashboard_info_data.dart';
import '../models/response/api_response.dart';
import '../utils/dio.dart';
import 'session_service.dart';

class _DashboardService {
  Future<DashboardInfoData> getDashboardInfo() async {
    final response = await dio.get('dashboard');
    final dashboardInfo =
        DashboardInfoData.fromDynamic(ApiResponse(response.data).data);
    return dashboardInfo.rebuild(
      (final b) => b.sessions
          .replace(sessionService.pipeSessions(dashboardInfo.sessions)),
    );
  }
}

final dashboardService = _DashboardService();
