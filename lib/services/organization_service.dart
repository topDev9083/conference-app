import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';

import '../core/constants.dart';
import '../models/data/organization_data.dart';
import '../models/params/pagination_param.dart';
import '../models/response/api_response.dart';
import '../utils/dio.dart';

class _OrganizationService {
  Future<BuiltList<OrganizationData>> searchOrganizations({
    final String? search,
    final PaginationParam? pagination,
    final CancelToken? cancelToken,
  }) async {
    final response = await dio.get(
      'organizations',
      queryParameters: {
        'offset': pagination?.offset,
        'limit': pagination?.limit ?? RECORDS_LIMIT,
        'name': search,
      }..removeWhere((final key, final value) => value == null || value == ''),
      cancelToken: cancelToken,
    );
    return OrganizationData.fromDynamics(ApiResponse(response.data).data);
  }

  Future<OrganizationData> updateOrganization({
    final String? name,
    final String? phoneNumber,
    final String? website,
    final String? email,
    final String? address,
    final String? city,
    final String? state,
    final String? zipCode,
    final String? profile,
    final int? countryId,
    final PlatformFile? logo,
  }) async {
    final data = json.encode({
      'name': name,
      'phoneNumber': phoneNumber,
      'website': website,
      'email': email,
      'address': address,
      'city': city,
      'state': state,
      'zipCode': zipCode,
      'profile': profile,
      'countryId': countryId,
    });
    final Map<String, dynamic> body = {
      'data': data,
    };
    if (logo != null) {
      if (kIsWeb) {
        body['organizationLogo'] = MultipartFile.fromBytes(
          logo.bytes!,
          filename: logo.name,
        );
      } else {
        body['organizationLogo'] = await MultipartFile.fromFile(logo.path!);
      }
    }
    final formData = FormData.fromMap(body);

    final response = await dio.put(
      'organizations',
      data: formData,
    );
    return OrganizationData.fromDynamic(ApiResponse(response.data).data);
  }
}

final organizationService = _OrganizationService();
