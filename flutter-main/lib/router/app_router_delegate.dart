import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';

import '../bloc/event_bloc.dart';
import '../bloc/event_code_bloc.dart';
import '../bloc/profile_bloc.dart';
import '../bloc/state/event_state.dart';
import '../pages/auth/auth_screen.dart';
import '../pages/home/home_screen.dart';
import '../pages/home/router/home_route_config.dart';
import '../pages/loading/loading_screen.dart';
import '../pages/select_event_code/select_event_code_screen.dart';
import 'app_route_bloc.dart';
import 'app_route_config.dart';

final _logger = Logger('app_router_delegate.dart');

class AppRouterDelegate extends RouterDelegate<AppRouteConfig>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  final GlobalKey<NavigatorState> _navigatorKey;
  final ProfileBloc profileBloc;
  bool _isLoggedIn;
  late StreamSubscription _profileBlocSub;
  late AppRouteBloc _appRouteBloc;

  @override
  GlobalKey<NavigatorState>? get navigatorKey => _navigatorKey;

  @override
  AppRouteConfig get currentConfiguration {
    _logger.info('currentConfiguration');
    return _appRouteBloc.state.routeConfig;
  }

  AppRouterDelegate({
    required this.profileBloc,
  })  : _navigatorKey = GlobalKey<NavigatorState>(),
        _isLoggedIn = profileBloc.state != null;

  void init({
    required final AppRouteBloc appRouteBloc,
  }) {
    _appRouteBloc = appRouteBloc;
    _profileBlocSub = profileBloc.stream
        .where((final profile) => _isLoggedIn != (profile != null))
        .listen((final profile) {
      _isLoggedIn = profile != null;
      if (_isLoggedIn) {
        _appRouteBloc.updateRouteConfig(
          const AppRouteConfig.home(),
        );
      } else {
        _appRouteBloc.updateRouteConfig(
          const AppRouteConfig.auth(),
        );
      }
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _profileBlocSub.cancel();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) {
    _logger.info('build: $_isLoggedIn || ${_appRouteBloc.state.routeConfig}');
    return BlocBuilder<EventCodeBloc, String?>(
      builder: (final _, final eventCode) => BlocBuilder<EventBloc, EventState>(
        builder: (final _, final eventState) {
          return Navigator(
            key: navigatorKey,
            pages: () {
              if (eventCode == null) {
                return [const SelectEventCodeScreen()];
              }
              if (eventState.getEventApi.data == null) {
                return [const LoadingScreen()];
              }
              if (_isLoggedIn) {
                return [const HomeScreen()];
              }
              return [const AuthScreen()];
            }(),
            onPopPage: (final route, final result) {
              if (!route.didPop(result)) return false;
              return true;
            },
          );
        },
      ),
    );
  }

  @override
  SynchronousFuture<void> setNewRoutePath(final configuration) {
    _logger.info('setNewRoutePath: $configuration');
    configuration.when(
      auth: (final auth) {
        if (!_isLoggedIn) {
          _appRouteBloc.updateRouteConfig(configuration);
        } else {
          _appRouteBloc.updateRouteConfig(
            const AppRouteConfig.home(),
          );
        }
      },
      home: (final home) {
        if (_isLoggedIn) {
          _appRouteBloc.updateRouteConfig(configuration);
        } else {
          _appRouteBloc.updateRouteConfig(
            const AppRouteConfig.auth(),
          );
        }
      },
    );
    return SynchronousFuture(null);
  }

  @override
  Future<void> setRestoredRoutePath(final configuration) {
    _logger.info('setRestoredRoutePath: $configuration');
    return super.setRestoredRoutePath(configuration);
  }

  @override
  Future<void> setInitialRoutePath(final configuration) {
    _logger.info('setInitialRoutePath: $configuration');
    return super.setInitialRoutePath(configuration);
  }

  @override
  Future<bool> popRoute() {
    final newRouteConfig = getNewRouteConfigOnPop();
    if (newRouteConfig != null) {
      _appRouteBloc.updateRouteConfig(newRouteConfig);
      return SynchronousFuture(true);
    }
    return super.popRoute();
  }

  AppRouteConfig? getNewRouteConfigOnPop() {
    return _appRouteBloc.state.routeConfig.whenOrNull<AppRouteConfig?>(
      auth: (final auth) => auth.whenOrNull(
        forgotPassword: () => const AppRouteConfig.auth(),
        signup: () => const AppRouteConfig.auth(),
      ),
      home: (final home) => home.maybeWhen<AppRouteConfig?>(
        orElse: () => const AppRouteConfig.home(),
        dashboard: () => null,
        scheduleMeetings: (final sm) => sm.selectedUserId == null
            ? const AppRouteConfig.home()
            : const AppRouteConfig.home(
                homeRouteConfig: HomeRouteConfig.scheduleMeetings(),
              ),
        messages: (final m) => m.selectedUserId == null
            ? const AppRouteConfig.home()
            : const AppRouteConfig.home(
                homeRouteConfig: HomeRouteConfig.messages(),
              ),
        leadScanner: (final ls) => ls.selectedUserId == null
            ? const AppRouteConfig.home()
            : const AppRouteConfig.home(
                homeRouteConfig: HomeRouteConfig.leadScanner(),
              ),
      ),
    );
  }

  void notifyConfigChanged() {
    notifyListeners();
  }
}
