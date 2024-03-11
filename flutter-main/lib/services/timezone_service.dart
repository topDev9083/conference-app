import 'package:built_collection/built_collection.dart';
import 'package:timezone/data/latest.dart' show initializeTimeZones;
import 'package:timezone/timezone.dart' as tz;

export 'package:timezone/timezone.dart';

class _TimezoneService {
  BuiltList<tz.Location>? locations;

  void initialize() {
    initializeTimeZones();
    locations = BuiltList(
      tz.timeZoneDatabase.locations.values.toList()
        ..sort(
          (final a, final b) =>
              a.currentTimeZone.offset.compareTo(b.currentTimeZone.offset),
        ),
    );
  }

  tz.Location getLocation(final String? locationName) {
    return tz.getLocation(locationName ?? 'Atlantic/Azores');
  }

  BuiltList<tz.Location> getAllLocations() {
    return locations!;
  }
}

final timezoneService = _TimezoneService();
