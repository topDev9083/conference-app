import 'package:built_collection/built_collection.dart';

import '../models/data/sponsor_data.dart';
import '../models/response/api_response.dart';
import '../utils/dio.dart';

class _SponsorService {
  Future<BuiltList<SponsorData>> getSponsors() async {
    final response = await dio.get('sponsors');
    return SponsorData.fromDynamics(
      ApiResponse(response.data).data as List<dynamic>,
    );
  }
}

final sponsorService = _SponsorService();
