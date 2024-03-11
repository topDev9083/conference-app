import 'package:flutter/foundation.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';

class _AudioService {
  Future<void> playNotificationSound() {
    if (kIsWeb) {
      return Future.delayed(Duration.zero);
    }
    return FlutterRingtonePlayer.playNotification();
  }
}

final audioService = _AudioService();
