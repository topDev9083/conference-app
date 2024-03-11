import 'dart:convert';
import 'dart:ui';

import 'package:built_collection/built_collection.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';

import '../core/constants.dart';
import '../models/data/time_slot_data.dart';
import '../models/data/user_data.dart';
import '../models/enums/meeting_status.dart';
import '../models/enums/order_by.dart';
import '../models/enums/sort_by.dart';
import '../models/params/pagination_param.dart';
import '../models/response/api_response.dart';
import '../utils/dio.dart';
import 'fcm_service.dart';
import 'session_service.dart';

class _UserService {
  Future<BuiltList<UserData>> getUsersByOrganizationId(
    final int organizationId, {
    final CancelToken? cancelToken,
  }) async {
    final response = await dio.get(
      'organizations/$organizationId/users',
      cancelToken: cancelToken,
    );
    return UserData.fromDynamics(ApiResponse(response.data).data);
  }

  Future<BuiltList<UserData>> searchUsers({
    final String? search,
    final PaginationParam? pagination,
    final SortBy? sortBy,
    final BuiltSet<int>? selectedCustomFieldIds,
    final BuiltSet<int>? selectedCountryIds,
    final BuiltSet<int>? selectedOrganizationIds,
    final BuiltSet<MeetingStatus>? selectedMeetingStatues,
    final CancelToken? cancelToken,
  }) async {
    final response = await dio.get(
      'users',
      queryParameters: {
        'offset': pagination?.offset,
        'limit': pagination?.limit ?? RECORDS_LIMIT,
        'keyword': search,
        'sortBy': sortBy == SortBy.namee ? null : sortBy,
        'sortOrder': sortBy == SortBy.createdOn ? OrderBy.desc : OrderBy.asc,
        'organizationIds': selectedOrganizationIds?.join(','),
        'countryIds': selectedCountryIds?.join(','),
        'meetingStatuses': selectedMeetingStatues?.join(','),
        for (int i = 0; i < (selectedCustomFieldIds?.length ?? 0); i++)
          '${selectedCustomFieldIds!.elementAt(i)}': true,
      }..removeWhere((final key, final value) => value == null || value == ''),
      cancelToken: cancelToken,
    );
    return UserData.fromDynamics(ApiResponse(response.data).data);
  }

  Future<UserData> updateProfile({
    final String? phoneNumber,
    final String? jobTitle,
    final String? linkedInUsername,
    final String? twitterUsername,
    final String? facebookUsername,
    final String? skypeUsername,
    final String? bio,
    required final Map<String, Object> customFieldValues,
    final PlatformFile? profilePicture,
  }) async {
    final data = json.encode({
      'customFieldsValues': customFieldValues,
      'phoneNumber': phoneNumber,
      'jobTitle': jobTitle,
      'linkedInUsername': linkedInUsername,
      'twitterUsername': twitterUsername,
      'facebookUsername': facebookUsername,
      'skypeUsername': skypeUsername,
      'bio': bio,
    });
    final Map<String, dynamic> body = {
      'data': data,
    };
    if (profilePicture != null) {
      if (kIsWeb) {
        body['profilePicture'] = MultipartFile.fromBytes(
          profilePicture.bytes!,
          filename: profilePicture.name,
        );
      } else {
        body['profilePicture'] =
            await MultipartFile.fromFile(profilePicture.path!);
      }
    }
    final formData = FormData.fromMap(body);
    final response = await dio.put(
      'user',
      data: formData,
    );
    return UserData.fromDynamic(ApiResponse(response.data).data);
  }

  Future<UserData> getUserById(
    final int userId, {
    final CancelToken? cancelToken,
  }) async {
    final response = await dio.get(
      'users/$userId',
      cancelToken: cancelToken,
    );
    return UserData.fromDynamic(ApiResponse(response.data).data);
  }

  Future<BuiltList<TimeSlotData>> getAvailableTimeSlotsByUserId(
    final int userId,
  ) async {
    final response = await dio.get('users/$userId/available-time-slots');
    return TimeSlotData.fromDynamics(ApiResponse(response.data).data);
  }

  Future<BuiltList<UserData>> searchUsersForMessaging({
    final String? search,
    final PaginationParam? pagination,
    final CancelToken? cancelToken,
  }) async {
    final response = await dio.get(
      'messages/users',
      queryParameters: {
        'offset': pagination?.offset,
        'limit': pagination?.limit ?? RECORDS_LIMIT,
        'keyword': search,
      }..removeWhere((final key, final value) => value == null || value == ''),
      cancelToken: cancelToken,
    );

    return UserData.fromDynamics(ApiResponse(response.data).data);
  }

  Future<void> updateFcmToken() async {
    final fcmToken = await fcmService.getToken();
    if (fcmToken == null) {
      return;
    }
    await dio.put(
      'user/fcm-token',
      data: {
        'fcmToken': fcmToken,
      },
    );
  }

  Future<BuiltList<UserData>> searchUsersByRoleAndGroupNameWithSessions({
    required final String roleName,
    required final String groupName,
    final String? search,
    final CancelToken? cancelToken,
  }) async {
    final response = await dio.get(
      'users/by-role-and-groups',
      queryParameters: {
        'role': roleName,
        'group': groupName,
        if (search != null) 'keyword': search,
      },
      cancelToken: cancelToken,
    );
    final users = UserData.fromDynamics(ApiResponse(response.data).data);
    final updatedUsers = ListBuilder<UserData>();
    for (final user in users) {
      final bUser = user.toBuilder();
      bUser.sessions = sessionService.pipeSessions(user.sessions!).toBuilder();
      updatedUsers.add(bUser.build());
    }
    return updatedUsers.build();
  }

  Future<void> changePassword({
    required final String currentPassword,
    required final String newPassword,
  }) {
    return dio.put(
      'user/change-password',
      data: {
        'currentPassword': currentPassword,
        'newPassword': newPassword,
      },
    );
  }

  final qrCodes = <String, Uint8List>{};

  Future<Uint8List> getQrCodeImage({
    final Color? color,
    required final String uniqueBy,
  }) async {
    if (qrCodes[uniqueBy] != null) {
      return qrCodes[uniqueBy]!;
    }
    final response = await dio.get(
      'user/qr-code',
      queryParameters: {
        if (color != null) 'color': '#${color.value.toRadixString(16)}',
        'uniqueBy': uniqueBy,
      },
      options: Options(
        responseType: ResponseType.bytes,
      ),
    );
    qrCodes[uniqueBy] = response.data as Uint8List;
    return qrCodes[uniqueBy]!;
  }
}

final userService = _UserService();
