import 'package:built_collection/built_collection.dart';

import '../core/constants.dart';
import '../models/data/country_data.dart';
import '../models/params/pagination_param.dart';
import '../models/response/api_response.dart';
import '../utils/dio.dart';

class _CountryService {
  Future<BuiltList<CountryData>> searchCountries({
    final String? search,
    final bool? showUsersCount,
    final PaginationParam? pagination,
    final CancelToken? cancelToken,
  }) async {
    final response = await dio.get(
      'countries',
      queryParameters: {
        'offset': pagination?.offset,
        'showUsersCount': showUsersCount,
        'limit': pagination?.limit ?? RECORDS_LIMIT,
        'name': search,
      }..removeWhere((final key, final value) => value == null || value == ''),
      cancelToken: cancelToken,
    );
    return CountryData.fromDynamics(ApiResponse(response.data).data);
  }
}

final countryService = _CountryService();
