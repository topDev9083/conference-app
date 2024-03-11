import 'package:built_collection/built_collection.dart';

import '../models/data/custom_field_data.dart';
import '../models/response/api_response.dart';
import '../utils/dio.dart';

class _CustomFieldService {
  Future<BuiltList<CustomFieldData>> getCustomFields() async {
    final response = await dio.get('custom-fields');
    return CustomFieldData.fromDynamics(
      ApiResponse(response.data).data as List<dynamic>,
    );
  }
}

final customFieldService = _CustomFieldService();
