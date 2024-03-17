import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../router/app_route_bloc.dart';
import '../../../../router/app_route_config.dart';
import '../../../../widgets/cubit.dart';
import '../../router/home_route_bloc.dart';
import '../../router/home_route_config.dart';
import 'schedule_meetings_route_state.dart';

class ScheduleMeetingsRouteBloc extends WCCubit<ScheduleMeetingsRouteState> {
  final AppRouteBloc appRouteBloc;
  final HomeRouteBloc homeRouteBloc;

  ScheduleMeetingsRouteBloc({
    required this.homeRouteBloc,
  })  : appRouteBloc = homeRouteBloc.appRouteBloc,
        super(ScheduleMeetingsRouteState());

  factory ScheduleMeetingsRouteBloc.of(final BuildContext context) =>
      BlocProvider.of<ScheduleMeetingsRouteBloc>(context);

  @override
  Future<void> close() {
    state.routeDelegate.dispose();
    return super.close();
  }

  void updateSelectedUserId(final int? userId) {
    final smConfig = appRouteBloc.state.routeConfig.whenOrNull(
      home: (final home) => home.whenOrNull(
        scheduleMeetings: (final sm) => sm,
      ),
    );
    if (smConfig == null) {
      return;
    }
    appRouteBloc.updateRouteConfig(
      AppRouteConfig.home(
        homeRouteConfig: HomeRouteConfig.scheduleMeetings(
          scheduleMeetingsRouteConfig: smConfig.copyWith(
            selectedUserId: userId,
          ),
        ),
      ),
    );
  }
}
