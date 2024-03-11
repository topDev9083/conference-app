import 'package:built_collection/built_collection.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';

import '../models/data/message_data.dart';
import '../models/enums/message_type.dart';
import '../models/response/api_response.dart';
import '../utils/dio.dart';

class _MessageService {
  Future<BuiltList<MessageData>> getMessagesByUserId(
    final int userId, {
    final CancelToken? cancelToken,
  }) async {
    final response = await dio.get(
      'messages/users/$userId/messages',
      cancelToken: cancelToken,
    );
    return MessageData.fromDynamics(
      ApiResponse(response.data).data as List<dynamic>,
    );
  }

  Future<int> getMessagesUnreadCount() async {
    final response = await dio.get('messages/unread-count');
    return ApiResponse(response.data).data as int;
  }

  Future<void> sendAttachment({
    required final int toUserId,
    required final PlatformFile file,
    required final MessageType type,
  }) async {
    final Map<String, dynamic> body = {
      'toUserId': toUserId,
      'type': type.name,
    };
    if (kIsWeb) {
      body['file'] = MultipartFile.fromBytes(
        file.bytes!,
        filename: file.name,
      );
    } else {
      body['file'] = await MultipartFile.fromFile(file.path!);
    }
    await dio.post(
      'messages/attachment',
      data: FormData.fromMap(body),
    );
  }
}

final messageService = _MessageService();
