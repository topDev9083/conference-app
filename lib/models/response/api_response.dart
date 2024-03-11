import 'package:dio/dio.dart';

import '../data/meta_data.dart';

class ApiResponse {
  final MetaData metaData;
  final dynamic data;

  ApiResponse(final dynamic json)
      : metaData = MetaData.fromDynamic(json['metaData']),
        data = json['data'];

  static MetaData getStrongMetaData(final dynamic e) {
    try {
      if (e is DioException) {
        if (e.response == null) {
          return MetaData(
            (final b) => b
              ..status = -1
              ..message = 'Internet connection failed'
              ..key = 'n/a',
          );
        } else if (e.response!.data['metaData'] != null) {
          return ApiResponse(e.response!.data).metaData;
        }
      }
      return MetaData(
        (final b) => b
          ..status = -1
          ..message = e.toString()
          ..key = 'n/a',
      );
    } catch (e) {
      return MetaData(
        (final b) => b
          ..status = -1
          ..message = e.toString()
          ..key = 'n/a',
      );
    }
  }
}
