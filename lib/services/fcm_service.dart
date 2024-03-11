import 'dart:async';
import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:logging/logging.dart';

import '../core/configs.dart';
import '../models/data/announcement_data.dart';
import '../models/data/feed_data.dart';
import '../models/data/meeting_data.dart';
import '../models/data/message_data.dart';
import 'announcement_service.dart';

final _logger = Logger('fcm_service.dart');

class _FCMService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  final _onTapMessageNotification = StreamController<MessageData>.broadcast();
  final _onTapMeetingNotification = StreamController<MeetingData>.broadcast();
  final _onTapAnnouncementNotification =
      StreamController<AnnouncementData>.broadcast();
  final _onTapFeedNotification = StreamController<FeedData>.broadcast();
  bool _isInitialized = false;

  Stream<MessageData> get onTapMessageNotification =>
      _onTapMessageNotification.stream;

  Stream<MeetingData> get onTapMeetingNotification =>
      _onTapMeetingNotification.stream;

  Stream<AnnouncementData> get onTapAnnouncementNotification =>
      _onTapAnnouncementNotification.stream;

  Stream<FeedData> get onTapFeedNotification => _onTapFeedNotification.stream;

  _FCMService._();

  void initialize() {
    if (_isInitialized) {
      return;
    }
    FirebaseMessaging.onMessage.listen((final event) {
      _logger.info('onMessage');
    });
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageTaped);
    _firebaseMessaging.getInitialMessage().then((final rm) {
      if (rm != null) {
        _onMessageTaped(rm);
      }
    });
    _isInitialized = true;
  }

  Future<void> _onMessageTaped(final RemoteMessage rm) async {
    try {
      if (rm.data.containsKey('message')) {
        final dMessage = json.decode(rm.data['message'] as String);
        _onTapMessageNotification.sink.add(MessageData.fromDynamic(dMessage));
      } else if (rm.data.containsKey('meeting')) {
        final dMeeting = json.decode(rm.data['meeting'] as String);
        _onTapMeetingNotification.sink.add(MeetingData.fromDynamic(dMeeting));
      } else if (rm.data.containsKey('announcement')) {
        final data = json.decode(rm.data['announcement']);
        final announcementId = data['announcementId'] as int;
        try {
          final announcement = await announcementService.getAnnouncementById(
            announcementId,
          );
          _onTapAnnouncementNotification.sink.add(announcement);
        } catch (e) {
          _logger.severe('_onMessageTaped: $e');
        }
      } else if (rm.data.containsKey('feed')) {
        final dFeed = json.decode(rm.data['feed'] as String);
        _onTapFeedNotification.sink.add(FeedData.fromDynamic(dFeed));
      }
    } catch (e) {
      _logger.severe(e.toString());
    }
  }

  Future<String?> getToken() async {
    if (await requestNotificationPermissions()) {
      final fcmToken = await _firebaseMessaging.getToken(
        vapidKey: config.webPushCertificate,
      );
      _logger.fine('getToken: $fcmToken');
      return fcmToken;
    } else {
      return null;
    }
  }

  Future<void> deleteToken() {
    return _firebaseMessaging.deleteToken();
  }

  void dispose() {
    _onTapMessageNotification.close();
    _onTapMeetingNotification.close();
  }

  Future<bool> requestNotificationPermissions() async {
    final result = await _firebaseMessaging.requestPermission(
      badge: false,
    );
    _logger
        .info('requestNotificationPermissions: ${result.authorizationStatus}');
    return result.authorizationStatus == AuthorizationStatus.authorized;
  }
}

final fcmService = _FCMService._();
