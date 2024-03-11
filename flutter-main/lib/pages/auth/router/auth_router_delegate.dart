import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../router/app_route_bloc.dart';
import '../../../router/app_route_state.dart';
import '../../empty/empty_screen.dart';
import '../forgot_password/forgot_password_screen.dart';
import '../login/login_screen.dart';
import '../signup/signup_screen.dart';
import 'auth_route_config.dart';

class AuthRouterDelegate extends RouterDelegate<AuthRouteConfig>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  final GlobalKey<NavigatorState> _navigatorKey;

  @override
  GlobalKey<NavigatorState>? get navigatorKey => _navigatorKey;

  AuthRouterDelegate() : _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(final BuildContext context) {
    final appRouteBloc = AppRouteBloc.of(context);
    return BlocBuilder<AppRouteBloc, AppRouteState>(
      buildWhen: (final prev, final next) =>
          next.routeConfig.maybeWhen(
            auth: (final _) => true,
            orElse: () => false,
          ) &&
          prev.routeConfig != next.routeConfig,
      builder: (final _, final state) => Navigator(
        key: navigatorKey,
        pages: [
          ...state.routeConfig.when(
            auth: (final auth) => auth.when(
              login: () => [
                const LoginScreen(),
              ],
              signup: () => [
                if (!kIsWeb) ...[
                  const LoginScreen(),
                ],
                const SignupScreen(),
              ],
              forgotPassword: () => [
                if (!kIsWeb) ...[
                  const LoginScreen(),
                ],
                const ForgotPasswordScreen(),
              ],
            ),
            home: (final _) => [
              const EmptyScreen(),
            ],
          ),
        ],
        onPopPage: (final route, final result) {
          if (!route.didPop(result)) return false;
          final newRouteConfig =
              appRouteBloc.state.routerDelegate.getNewRouteConfigOnPop();
          if (newRouteConfig != null) {
            appRouteBloc.updateRouteConfig(newRouteConfig);
          }
          return true;
        },
      ),
    );
  }

  @override
  SynchronousFuture<void> setNewRoutePath(final AuthRouteConfig configuration) {
    return SynchronousFuture(null);
  }
}
