import 'dart:io';

import 'package:flutter/foundation.dart';

import '../models/data/meta_data.dart';
import '../models/data/user_data.dart';
import '../models/response/api_response.dart';
import '../utils/dio.dart';
import 'fcm_service.dart';

class _AuthService {
  UserData? _currentUser;

  UserData? get currentUser => _currentUser;

  Future<UserData> login({
    required final String email,
    required final String password,
    required final String eventCode,
  }) async {
    String? fcmToken;
    if (!kIsWeb && Platform.isAndroid) {
      fcmToken = await fcmService.getToken();
    }
    final response = await dio.post(
      'user/auth/login',
      data: {
        'email': email,
        'password': password,
        if (fcmToken != null) ...{
          'fcmToken': fcmToken,
        },
      },
      options: Options(
        headers: {
          Headers.EVENT_CODE: eventCode,
        },
      ),
    );
    _currentUser = UserData.fromDynamic(ApiResponse(response.data).data);
    return _currentUser!;
  }

  Future<void> signup({
    required final String fullName,
    required final String email,
    required final String password,
    required final String eventCode,
  }) {
    return dio.post(
      'user/auth/signup',
      data: {
        'fullName': fullName,
        'email': email,
        'password': password,
      },
      options: Options(
        headers: {
          Headers.EVENT_CODE: eventCode,
        },
      ),
    );
  }

  Future<MetaData> forgotPassword(
    final String email,
    final String eventCode,
  ) async {
    final response = await dio.post(
      'user/auth/forgot-password',
      data: {
        'email': email,
      },
      options: Options(
        headers: {
          Headers.EVENT_CODE: eventCode,
        },
      ),
    );
    return ApiResponse(response.data).metaData;
  }

  Future<UserData> getProfile() async {
    final response = await dio.get('user');
    return UserData.fromDynamic(ApiResponse(response.data).data);
  }

  void updateCurrentUser(final UserData? currentUser) {
    _currentUser = currentUser;
  }
}

final authService = _AuthService();
