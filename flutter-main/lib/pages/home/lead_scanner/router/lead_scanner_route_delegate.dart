import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../router/app_route_bloc.dart';
import '../../../../router/app_route_state.dart';
import '../../../../utils/screen.dart';
import '../lead_scanner_detail/lead_scanner_detail_screen.dart';
import '../lead_scanner_detail/lead_scanner_no_detail_screen.dart';
import 'lead_scanner_route_config.dart';

class LeadScannerRouteDelegate extends RouterDelegate<LeadScannerRouteConfig>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  final GlobalKey<NavigatorState> _navigatorKey;

  @override
  GlobalKey<NavigatorState>? get navigatorKey => _navigatorKey;

  LeadScannerRouteDelegate() : _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(final BuildContext context) {
    return BlocBuilder<AppRouteBloc, AppRouteState>(
      buildWhen: (final prev, final next) =>
          next.routeConfig.maybeWhen(
            home: (final home) => home.maybeWhen(
              leadScanner: (final _) => true,
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
                  leadScanner: (final ls) {
                    if (ls.selectedUserId != null) {
                      return LeadScannerDetailScreen(
                        selectedUserId: ls.selectedUserId!,
                      );
                    }
                    return null;
                  },
                ),
              ) ??
              const LeadScannerNoDetailScreen(),
        ],
        onPopPage: (final route, final result) {
          if (!route.didPop(result)) return false;
          return true;
        },
      ),
    );
  }

  @override
  SynchronousFuture<void> setNewRoutePath(
    final LeadScannerRouteConfig configuration,
  ) {
    return SynchronousFuture(null);
  }
}
