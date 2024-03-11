import '../models/data/map_location_data.dart';
import '../models/response/api_response.dart';
import '../utils/dio.dart';

class _MapLocationService {
  Future<MapLocationData> getMapLocationById(final int id) async {
    final response = await dio.get('map-locations/$id');
    return MapLocationData.fromDynamic(ApiResponse(response.data).data);
  }
}

final mapLocationService = _MapLocationService();
