import 'package:flutter/material.dart';

import '../extensions/date_time.dart';
import '../utils/color_utils.dart';
import 'time_zone_bloc_builder.dart';

class BaseChip extends StatelessWidget {
  final String title;

  const BaseChip(this.title);

  @override
  Widget build(final BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: ColorUtils.lighten(
          Theme.of(context).primaryColor,
          0.9,
        ),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: Theme.of(context).primaryColor,
          fontSize: 12,
        ),
      ),
    );
  }
}

class DateTimeChip extends StatelessWidget {
  final DateTime startDate;
  final DateTime endDate;

  const DateTimeChip({
    required this.startDate,
    required this.endDate,
  });

  @override
  Widget build(final BuildContext context) {
    return TimeZoneBlocBuilder(
      builder: (final timeZone) => BaseChip(
        '${startDate.format(
          format: 'EEE, dd MMM, hh:mm aa',
          timeZone: timeZone,
        )}-${endDate.format(
          format: 'hh:mm aa',
          timeZone: timeZone,
        )}',
      ),
    );
  }
}
