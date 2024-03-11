import 'package:dio/dio.dart';
import 'package:logging/logging.dart';

import '../bloc/profile_bloc.dart';
import '../core/configs.dart';
import '../services/auth_service.dart';

export 'package:dio/dio.dart';

final _logger = Logger('dio.dart');

Dio _initDio() {
  final apiUrl = '${config.apiUrl}/api/v1/';
  final headers = <String, dynamic>{};
  final options = BaseOptions(
    baseUrl: apiUrl,
    headers: headers,
    connectTimeout: const Duration(milliseconds: 60000),
    receiveTimeout: const Duration(milliseconds: 60000),
  );
  final dio = Dio(options);
  dio.interceptors.add(_CustomInterceptor(dio));
  return dio;
}

class _CustomInterceptor extends Interceptor {
  final Dio dio;

  _CustomInterceptor(this.dio);

  @override
  void onRequest(
    final RequestOptions options,
    final RequestInterceptorHandler handler,
  ) {
    final currentUser = authService.currentUser;
    if (currentUser?.authorization != null) {
      options.headers['Authorization'] = currentUser!.authorization;
    }
    super.onRequest(options, handler);
  }

  @override
  void onError(final DioException err, final ErrorInterceptorHandler handler) {
    _logger.severe(
      'PATH: ${err.requestOptions.method} ${err.requestOptions.path} || ERROR: ${err.message}',
    );
    super.onError(err, handler);
  }
}

final Dio dio = _initDio();

void cancelDioToken(final CancelToken? token) {
  try {
    if (!(token?.isCancelled == true)) {
      token?.cancel();
    }
  } catch (_) {}
}

class LogoutInterceptor extends Interceptor {
  final ProfileBloc profileBloc;

  LogoutInterceptor(this.profileBloc);

  @override
  void onError(final DioException err, final ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      profileBloc.logout();
    }
    super.onError(err, handler);
  }
}

class Headers {
  static const EVENT_CODE = 'EventCode';

  const Headers._();
}
