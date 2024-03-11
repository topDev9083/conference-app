import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/profile_bloc.dart';
import '../widgets/cubit.dart';
import 'app_route_config.dart';
import 'app_route_state.dart';
import 'app_router_delegate.dart';

class AppRouteBloc extends WCCubit<AppRouteState> {
  AppRouteBloc({
    required final ProfileBloc profileBloc,
  }) : super(
          AppRouteState(
            (final b) => b
              ..routerDelegate = AppRouterDelegate(
                profileBloc: profileBloc,
              )
              ..routeConfig = profileBloc.state != null
                  ? const AppRouteConfig.home()
                  : const AppRouteConfig.auth(),
          ),
        ) {
    state.routerDelegate.init(
      appRouteBloc: this,
    );
  }

  factory AppRouteBloc.of(final BuildContext context) =>
      BlocProvider.of<AppRouteBloc>(context);

  void updateRouteConfig(final AppRouteConfig config) {
    emit(state.rebuild((final b) => b.routeConfig = config));
    state.routerDelegate.notifyConfigChanged();
  }

  @override
  Future<void> close() {
    state.routerDelegate.dispose();
    return super.close();
  }
}
