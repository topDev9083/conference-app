import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/screen.dart';
import '../router/home_route_bloc.dart';
import 'messages_fragment.dart';
import 'router/messages_route_bloc.dart';

class MessagesScreen extends Screen {
  static const ROUTE_NAME = 'messages';

  const MessagesScreen()
      : super(
          staticAnimation: true,
        );

  @override
  Widget createChild(final BuildContext context) {
    return BlocProvider(
      create: (final _) => MessagesRouteBloc(
        homeRouteBloc: HomeRouteBloc.of(context),
      ),
      child: const MessagesFragment(),
    );
  }
}
