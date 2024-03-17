import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../router/app_route_bloc.dart';
import '../../../router/app_route_config.dart';
import '../../../widgets/cubit.dart';
import 'home_route_config.dart';
import 'home_route_state.dart';

class HomeRouteBloc extends WCCubit<HomeRouteState> {
  final AppRouteBloc appRouteBloc;

  HomeRouteBloc({
    required this.appRouteBloc,
  }) : super(HomeRouteState());

  factory HomeRouteBloc.of(final BuildContext context) =>
      BlocProvider.of<HomeRouteBloc>(context);

  @override
  Future<void> close() {
    state.routerDelegate.dispose();
    return super.close();
  }

  void updateRouteConfig(final HomeRouteConfig config) {
    appRouteBloc.updateRouteConfig(
      AppRouteConfig.home(
        homeRouteConfig: config,
      ),
    );
  }
}
