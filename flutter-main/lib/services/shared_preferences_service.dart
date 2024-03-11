import 'package:logging/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/data/event_data.dart';

final _logger = Logger('shared_preferences_service.dart');

class _SharedPreferencesService {
  late SharedPreferences _prefs;

  Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
  }

  EventData? getEvent() {
    try {
      final mEvent = _prefs.get('event');
      if (mEvent == null) {
        return null;
      }
      return EventData.fromDynamic(mEvent);
    } catch (e) {
      _logger.severe(e.toString(), e);
    }
    return null;
  }
}

final sharedPreferencesService = _SharedPreferencesService();
