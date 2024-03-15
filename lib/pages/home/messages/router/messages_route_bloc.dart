import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../router/app_route_bloc.dart';
import '../../../../router/app_route_config.dart';
import '../../../../widgets/cubit.dart';
import '../../router/home_route_bloc.dart';
import '../../router/home_route_config.dart';
import 'messages_route_config.dart';
import 'messages_route_state.dart';

class MessagesRouteBloc extends WCCubit<MessagesRouteState> {
  final AppRouteBloc appRouteBloc;
  final HomeRouteBloc homeRouteBloc;

  MessagesRouteBloc({
    required this.homeRouteBloc,
  })  : appRouteBloc = homeRouteBloc.appRouteBloc,
        super(MessagesRouteState());

  factory MessagesRouteBloc.of(final BuildContext context) =>
      BlocProvider.of<MessagesRouteBloc>(context);

  @override
  Future<void> close() {
    state.routeDelegate.dispose();
    return super.close();
  }

  void updateSelectedUserId(final int? selectedUserId) {
    appRouteBloc.updateRouteConfig(
      AppRouteConfig.home(
        homeRouteConfig: HomeRouteConfig.messages(
          messagesRouteConfig: MessagesRouteConfig(
            selectedUserId: selectedUserId,
          ),
        ),
      ),
    );
  }
}
