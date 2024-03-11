import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../router/app_route_bloc.dart';
import '../../../router/app_route_config.dart';
import '../../../widgets/cubit.dart';
import 'auth_route_config.dart';
import 'auth_route_state.dart';

class AuthRouteBloc extends WCCubit<AuthRouteState> {
  AppRouteBloc appRouteBloc;

  AuthRouteBloc({
    required this.appRouteBloc,
  }) : super(AuthRouteState());

  factory AuthRouteBloc.of(final BuildContext context) =>
      BlocProvider.of<AuthRouteBloc>(context);

  @override
  Future<void> close() {
    state.routerDelegate.dispose();
    return super.close();
  }

  void updateRouteConfig(final AuthRouteConfig config) {
    appRouteBloc.updateRouteConfig(
      AppRouteConfig.auth(
        authRouteConfig: config,
      ),
    );
  }
}
