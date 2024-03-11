import 'package:built_collection/built_collection.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

import '../models/data/feed_comment_data.dart';
import '../models/data/feed_data.dart';
import '../models/response/api_response.dart';
import '../utils/dio.dart';

class _FeedService {
  Future<FeedData> createFeed({
    final String? text,
    final XFile? image,
  }) async {
    final Map<String, dynamic> body = {};
    if (text != null) {
      body['text'] = text;
    }
    if (image != null) {
      if (kIsWeb) {
        body['image'] = MultipartFile.fromBytes(
          await image.readAsBytes(),
          filename: image.name,
        );
      } else {
        body['image'] = await MultipartFile.fromFile(image.path);
      }
    }
    final response = await dio.post(
      'feeds',
      data: FormData.fromMap(body),
    );
    return FeedData.fromDynamic(ApiResponse(response.data).data);
  }

  Future<BuiltList<FeedData>> getFeeds() async {
    final response = await dio.get('feeds');
    return FeedData.fromDynamics(ApiResponse(response.data).data);
  }

  Future<void> deleteFeedById(final int feedId) {
    return dio.delete('feed/$feedId');
  }

  Future<FeedData> likeOrUnlikeFeedById(
    final int feedId,
    final bool isLike,
  ) async {
    final response = await dio.put(
      'feeds/$feedId/like',
      data: {
        'isLike': isLike,
      },
    );
    return FeedData.fromDynamic(ApiResponse(response.data).data);
  }

  Future<BuiltList<FeedCommentData>> getCommentsByFeedId(
    final int feedId,
  ) async {
    final response = await dio.get('feeds/$feedId/comments');
    return FeedCommentData.fromDynamics(ApiResponse(response.data).data);
  }

  Future<FeedCommentData> createFeedComment(
    final int feedId, {
    required final String text,
  }) async {
    final response = await dio.post(
      'feeds/$feedId/comments',
      data: {
        'text': text,
      },
    );
    return FeedCommentData.fromDynamic(ApiResponse(response.data).data);
  }

  Future<FeedData> watchSnoozeFeed(final int feedId, final bool watch) async {
    final response = await dio.put(
      'feeds/$feedId/watch-snooze',
      data: {
        'watch': watch,
      },
    );
    return FeedData.fromDynamic(ApiResponse(response.data).data);
  }
}

final feedService = _FeedService();
