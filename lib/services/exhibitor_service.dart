import 'package:built_collection/built_collection.dart';

import '../models/data/exhibitor_data.dart';
import '../models/response/api_response.dart';
import '../utils/dio.dart';

class _ExhibitorService {
  Future<BuiltList<ExhibitorData>> getExhibitors({
    final String? search,
  }) async {
    final response = await dio.get(
      'exhibitors',
      queryParameters: {
        if (search != null) 'keyword': search,
      },
    );
    return ExhibitorData.fromDynamics(
      ApiResponse(response.data).data as List<dynamic>,
    );
  }
}

final exhibitorService = _ExhibitorService();
