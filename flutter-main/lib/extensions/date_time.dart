import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as time_ago;

import '../models/data/time_zone_data.dart';
import '../services/timezone_service.dart';

extension DateTimeExtension on DateTime {
  DateTime toDateTimeOnly() {
    if (isUtc) {
      return DateTime.utc(year, month, day, hour, minute);
    } else {
      return DateTime(year, month, day, hour, minute);
    }
  }

  bool isAtSameDateAs(
    final DateTime dateTime, {
    final String? zone,
  }) {
    final location = timezoneService.getLocation(zone);
    final tzThis = TZDateTime.from(
      this,
      location,
    ).toLocal();
    final tzOther = TZDateTime.from(
      dateTime,
      location,
    ).toLocal();

    return tzThis.year == tzOther.year &&
        tzThis.month == tzOther.month &&
        tzThis.day == tzOther.day;
  }

  TZDateTime toTZWithoutChange(
    final String zone, {
    final bool readTime = true,
  }) {
    return TZDateTime(
      timezoneService.getLocation(zone),
      year,
      month,
      day,
      readTime ? hour : 0,
      readTime ? minute : 0,
      readTime ? second : 0,
      readTime ? millisecond : 0,
      readTime ? microsecond : 0,
    );
  }

  String format({
    required final String format,
    required final TimeZoneData? timeZone,
    final String? locale,
  }) {
    final df = DateFormat(format, locale);
    if (timeZone == null) {
      return df.format(toLocal());
    } else {
      final location = timezoneService.getLocation(timeZone.zone);
      final tzDateTime = TZDateTime.from(this, location);
      return df.format(tzDateTime);
    }
  }

  String timeAgo({
    required final TimeZoneData timeZone,
    final String timeFormat = 'hh:mm a',
    final String dateFormat = 'dd MMM hh:mm a',
    final String yearFormat = 'dd MMM, yyyy hh:mm a',
    final String? locale,
  }) {
    final diff = DateTime.now().difference(this);
    if (diff.inMilliseconds > (Duration.millisecondsPerDay * 365)) {
      return format(
        format: yearFormat,
        timeZone: timeZone,
        locale: locale,
      );
    } else if (diff.inMilliseconds > Duration.millisecondsPerDay) {
      return format(
        format: dateFormat,
        timeZone: timeZone,
        locale: locale,
      );
    } else if (diff.inMilliseconds > Duration.millisecondsPerHour) {
      return format(
        format: timeFormat,
        timeZone: timeZone,
        locale: locale,
      );
    } else {
      final ago = DateTime.now().subtract(diff);
      final sAgo = time_ago
          .format(
            ago,
            locale: locale ?? 'en_short',
          )
          .replaceAll(' ', '')
          .replaceAll('~', '');
      if (sAgo == 'now') {
        return sAgo;
      } else {
        return '$sAgo ago';
      }
    }
  }
}
