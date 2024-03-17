import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/screen.dart';
import '../router/home_route_bloc.dart';
import 'router/schedule_meetings_route_bloc.dart';
import 'schedule_meetings_fragment.dart';

class ScheduleMeetingsScreen extends Screen {
  static const ROUTE_NAME = 'schedule-meetings';

  const ScheduleMeetingsScreen()
      : super(
          staticAnimation: true,
        );

  @override
  Widget createChild(final BuildContext context) {
    return BlocProvider(
      create: (final _) => ScheduleMeetingsRouteBloc(
        homeRouteBloc: HomeRouteBloc.of(context),
      ),
      child: const ScheduleMeetingsFragment(),
    );
  }
}
