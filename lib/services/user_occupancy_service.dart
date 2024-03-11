import '../models/data/user_occupancy_data.dart';
import '../models/response/api_response.dart';
import '../utils/dio.dart';

class _UserOccupancyService {
  Future<UserOccupancyData> createUserOccupancy({
    required final DateTime startDate,
    required final DateTime endDate,
    final String? reason,
  }) async {
    final response = await dio.post(
      'user-occupancies',
      data: {
        'startDate': startDate.millisecondsSinceEpoch,
        'endDate': endDate.millisecondsSinceEpoch,
        if (reason != null && reason.isNotEmpty) 'reason': reason,
      },
    );
    return UserOccupancyData.fromDynamic(ApiResponse(response.data).data);
  }

  Future<void> deleteUserOccupancyById(final int id) {
    return dio.delete('user-occupancies/$id');
  }
}

final userOccupancyService = _UserOccupancyService();
