import 'dart:async';
import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:logging/logging.dart';
import 'package:rxdart/rxdart.dart';
import 'package:socket_io_client/socket_io_client.dart';

import '../core/configs.dart';
import '../models/data/announcement_data.dart';
import '../models/data/feed_comment_data.dart';
import '../models/data/feed_data.dart';
import '../models/data/meeting_data.dart';
import '../models/data/message_data.dart';
import '../models/data/meta_data.dart';
import '../models/data/notification_data.dart';
import '../models/data/send_text_message_data.dart';
import '../models/data/socket_notification_data.dart';
import '../models/response/api_response.dart';
import 'auth_service.dart';

final _logger = Logger('socket_service.dart');

class _SocketService {
  int? selectedMessageUserId;

  final _onConnectionChangedStream = BehaviorSubject<bool>();
  final _onErrorStream = StreamController<MetaData>.broadcast();
  final _onCustomErrorStream = StreamController<MetaData>.broadcast();
  final _onUsersOnlineStream =
      BehaviorSubject<BuiltSet<int>>.seeded(BuiltSet());
  final _onMessageStream = StreamController<MessageData>.broadcast();
  final _onScheduleMeetingStream =
      StreamController<SocketNotificationData<MeetingData>>.broadcast();
  final _onMeetingReminderStream =
      StreamController<SocketNotificationData<MeetingData>>.broadcast();
  final _onAnnouncementStream = StreamController<AnnouncementData>.broadcast();
  final _onFeedStream = StreamController<FeedData>.broadcast();
  final _onFeedCommentStream = StreamController<FeedCommentData>.broadcast();
  int? _lastMessageId;
  int? _lastAnnouncementId;
  Socket? _socket;

  ValueStream<bool> get onConnectionChanged =>
      _onConnectionChangedStream.stream;

  Stream<MetaData> get onError => _onErrorStream.stream;

  Stream<MetaData> get onCustomError => _onCustomErrorStream.stream;

  ValueStream<BuiltSet<int>> get onUsersOnline => _onUsersOnlineStream.stream;

  Stream<MessageData> get onMessage => _onMessageStream.stream;

  Stream<SocketNotificationData<MeetingData>> get onScheduleMeeting =>
      _onScheduleMeetingStream.stream;

  Stream<SocketNotificationData<MeetingData>> get onMeetingReminder =>
      _onMeetingReminderStream.stream;

  Stream<AnnouncementData> get onAnnouncement => _onAnnouncementStream.stream;

  Stream<FeedData> get onFeed => _onFeedStream.stream;

  Stream<FeedCommentData> get onFeedComment => _onFeedCommentStream.stream;

  void connect() {
    _socket = io(
      '${config.apiUrl}/ws/v1/users',
      OptionBuilder().setTransports([
        'websocket',
      ]).setAuth({
        'Authorization': authService.currentUser?.authorization ?? '',
      }).build(),
    );
    // if error is thrown by server
    _socket!.on('error', _onError);
    // if connection is failed with server
    _socket!.on('connect_error', _onConnectError);
    _socket!.on('connect', _onConnect);
    _socket!.on('disconnect', _onDisconnect);
    _socket!.on('customError', _onCustomError);
    _socket!.on('usersOnline', _onUsersOnline);

    _socket!.on('message', _onMessage);
    _socket!.on('scheduleMeeting', _onScheduleMeeting);
    _socket!.on('meetingReminder', _onMeetingReminder);
    _socket!.on('announcement', _onAnnouncement);
    _socket!.on('feed', _onFeed);
    _socket!.on('feedComment', _onFeedComment);
  }

  void dispose() {
    _socket?.close();
    _socket?.dispose();
    _socket = null;
  }

  void _onError(final dynamic error) {
    _logger.severe('_onError: $error');
    try {
      final metaData = ApiResponse(json.decode(error as String)).metaData;
      _onErrorStream.sink.add(metaData);
    } catch (_) {}
  }

  void _onConnectError(final dynamic error) {
    _logger.severe('_onConnectError: $error');
  }

  void _onConnect(final _) {
    _logger.info('_onConnect');
    _onConnectionChangedStream.sink.add(true);
  }

  void _onDisconnect(final _) {
    _logger.info('_onDisconnect');
    _onConnectionChangedStream.sink.add(false);
  }

  void _onCustomError(final dynamic data) {
    _logger.severe('_onCustomError: ${data.toString()}');
    final metaData = ApiResponse(data).metaData;
    _onCustomErrorStream.sink.add(metaData);
  }

  void _onUsersOnline(final dynamic data) {
    _logger.info('_onUsersOnline: ${data.toString()}');
    final dynamicList = ApiResponse(data).data['userIds'] as List<dynamic>;
    final list = BuiltSet<int>(dynamicList.map((final item) => item as int));
    _onUsersOnlineStream.sink.add(list);
  }

  void _onMessage(final dynamic data) {
    _logger.info('_onMessage: ${data.toString()}');
    final message = MessageData.fromDynamic(ApiResponse(data).data);
    if (_lastMessageId == message.id) {
      return;
    }
    _lastMessageId = message.id;
    _onMessageStream.sink.add(message);
  }

  void _onScheduleMeeting(final dynamic data) {
    _logger.info('_onScheduleMeeting: ${data.toString()}');
    final apiData = ApiResponse(data).data;
    _onScheduleMeetingStream.sink.add(
      SocketNotificationData<MeetingData>(
        (final b) => b
          ..notification
              .replace(NotificationData.fromDynamic(apiData['notification']))
          ..body = MeetingData.fromDynamic(apiData['meeting']),
      ),
    );
  }

  void _onMeetingReminder(final dynamic data) {
    _logger.info('_onMeetingNotification: ${data.toString()}');
    final apiData = ApiResponse(data).data;
    _onMeetingReminderStream.sink.add(
      SocketNotificationData<MeetingData>(
        (final b) => b
          ..notification
              .replace(NotificationData.fromDynamic(apiData['notification']))
          ..body = MeetingData.fromDynamic(apiData['meeting']),
      ),
    );
  }

  void _onAnnouncement(final dynamic data) {
    _logger.info('_onAnnouncement: ${data.toString()}');
    final announcement = AnnouncementData.fromDynamic(ApiResponse(data).data);
    if (_lastAnnouncementId == announcement.id) {
      return;
    }
    _lastAnnouncementId = announcement.id;
    _onAnnouncementStream.sink.add(announcement);
  }

  void _onFeed(final dynamic data) {
    _logger.info('_onFeed: ${data.toString()}');
    _onFeedStream.sink.add(FeedData.fromDynamic(ApiResponse(data).data['feed']));
  }

  void _onFeedComment(final dynamic data) {
    _logger.info('_onMeetingNotification: ${data.toString()}');
    final apiData = ApiResponse(data).data;
    _onFeedCommentStream.sink.add(
      FeedCommentData.fromDynamic(apiData['comment']),
    );
  }

  void sendMessage(final SendTextMessageData obj) {
    _socket?.emit('message', obj.toDynamic());
  }

  void markMessagesAsRead(final int fromUserId) {
    _socket?.emit('markMessagesAsRead', {
      'fromUserId': fromUserId,
    });
  }
}

final socketService = _SocketService();
