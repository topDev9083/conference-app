import 'package:built_collection/built_collection.dart';

import '../core/constants.dart';
import '../models/data/user_data.dart';
import '../models/params/pagination_param.dart';
import '../models/response/api_response.dart';
import '../utils/dio.dart';

class _ScannedUserService {
  Future<BuiltList<UserData>> getUsers({
    final PaginationParam? pagination,
    final CancelToken? cancelToken,
  }) async {
    final response = await dio.get(
      'scanned-users',
      queryParameters: {
        'offset': pagination?.offset,
        'limit': pagination?.limit ?? RECORDS_LIMIT,
      },
      cancelToken: cancelToken,
    );
    return UserData.fromDynamics(ApiResponse(response.data).data);
  }

  Future<UserData> addUser(final String qrCode) async {
    final response = await dio.post(
      'scanned-users',
      data: {
        'qrCode': qrCode,
      },
    );
    return UserData.fromDynamic(ApiResponse(response.data).data);
  }

  Future<void> deleteUser(final int userId) {
    return dio.delete(
      'scanned-users',
      data: {
        'userId': userId,
      },
    );
  }

  Future<String> getUsersCsv() async {
    final response = await dio.get('scanned-users/export/csv');
    return response.data;
  }
}

final scannedUserService = _ScannedUserService();
