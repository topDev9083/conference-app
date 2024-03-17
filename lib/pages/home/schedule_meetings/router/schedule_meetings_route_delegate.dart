import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../router/app_route_bloc.dart';
import '../../../../router/app_route_state.dart';
import '../../../../utils/screen.dart';
import '../schedule_meeting_detail/meeting_widgets/schedule_meeting_no_detail_screen.dart';
import '../schedule_meeting_detail/schedule_meeting_detail_screen.dart';
import 'schedule_meetings_route_config.dart';

class ScheduleMeetingsRouteDelegate
    extends RouterDelegate<ScheduleMeetingsRouteConfig>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  final GlobalKey<NavigatorState> _navigatorKey;

  @override
  GlobalKey<NavigatorState>? get navigatorKey => _navigatorKey;

  ScheduleMeetingsRouteDelegate() : _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(final BuildContext context) {
    return BlocBuilder<AppRouteBloc, AppRouteState>(
      buildWhen: (final prev, final next) =>
          next.routeConfig.maybeWhen(
            home: (final home) => home.maybeWhen(
              scheduleMeetings: (final _) => true,
              orElse: () => false,
            ),
            orElse: () => false,
          ) &&
          prev.routeConfig != next.routeConfig,
      builder: (final _, final state) => Navigator(
        key: navigatorKey,
        pages: [
          state.routeConfig.whenOrNull<Screen?>(
                home: (final home) => home.whenOrNull<Screen?>(
                  scheduleMeetings: (final sm) {
                    if (sm.selectedUserId == null) {
                      return null;
                    }
                    return ScheduleMeetingDetailScreen(
                      userId: sm.selectedUserId!,
                    );
                  },
                ),
              ) ??
              const ScheduleMeetingNoDetailScreen(),
        ],
        onPopPage: (final route, final result) {
          if (!route.didPop(result)) return false;
          return true;
        },
      ),
    );
  }

  @override
  SynchronousFuture<void> setNewRoutePath(final configuration) {
    return SynchronousFuture(null);
  }
}
