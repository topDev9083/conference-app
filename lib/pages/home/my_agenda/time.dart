import 'package:flutter/material.dart';

import '../../../extensions/date_time.dart';
import '../../../widgets/time_zone_bloc_builder.dart';

class Time extends StatelessWidget {
  final DateTime start;
  final DateTime end;

  const Time({
    required this.start,
    required this.end,
  });

  @override
  Widget build(final BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 29),
        TimeZoneBlocBuilder(
          builder: (final timeZone) => Text(
            '${start.format(
              format: 'hh:mm a',
              timeZone: timeZone,
            )}-${end.format(
              format: 'hh:mm a',
              timeZone: timeZone,
            )}',
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 12,
            ),
          ),
        ),
        const SizedBox(width: 25),
      ],
    );
  }
}
