import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../router/app_route_bloc.dart';
import '../../../../router/app_route_state.dart';
import '../../../../utils/screen.dart';
import '../thread_detail/thread_detail_screen.dart';
import '../thread_detail/thread_no_detail_screen.dart';
import 'messages_route_config.dart';

class MessagesRouteDelegate extends RouterDelegate<MessagesRouteConfig>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  final GlobalKey<NavigatorState> _navigatorKey;

  @override
  GlobalKey<NavigatorState>? get navigatorKey => _navigatorKey;

  MessagesRouteDelegate() : _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(final BuildContext context) {
    return BlocBuilder<AppRouteBloc, AppRouteState>(
      buildWhen: (final prev, final next) =>
          next.routeConfig.maybeWhen(
            home: (final home) => home.maybeWhen(
              messages: (final _) => true,
              orElse: () => false,
            ),
            orElse: () => false,
          ) &&
          prev.routeConfig != next.routeConfig,
      builder: (final _, final state) => WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Navigator(
          key: navigatorKey,
          pages: [
            state.routeConfig.whenOrNull<Screen?>(
                  home: (final home) => home.whenOrNull<Screen?>(
                    messages: (final messages) {
                      if (messages.selectedUserId != null) {
                        return ThreadDetailScreen(
                          selectedUserId: messages.selectedUserId!,
                        );
                      }
                      return null;
                    },
                  ),
                ) ??
                const ThreadNoDetailScreen(),
          ],
          onPopPage: (final route, final result) {
            if (!route.didPop(result)) return false;
            return true;
          },
        ),
      ),
    );
  }

  @override
  SynchronousFuture<void> setNewRoutePath(
    final MessagesRouteConfig configuration,
  ) {
    return SynchronousFuture(null);
  }
}
