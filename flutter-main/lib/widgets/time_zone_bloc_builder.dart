import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/event_bloc.dart';
import '../bloc/state/event_state.dart';
import '../models/data/time_zone_data.dart';

class TimeZoneBlocBuilder extends StatelessWidget {
  final Widget Function(TimeZoneData timeZone) builder;

  const TimeZoneBlocBuilder({
    required this.builder,
  });

  static TimeZoneData of(final BuildContext context) =>
      EventBloc.of(context).state.getEventApi.data!.timeZone!;

  @override
  Widget build(final BuildContext context) {
    return BlocSelector<EventBloc, EventState, TimeZoneData>(
      selector: (final state) => state.getEventApi.data!.timeZone!,
      builder: (final _, final timeZone) => builder(timeZone),
    );
  }
}
