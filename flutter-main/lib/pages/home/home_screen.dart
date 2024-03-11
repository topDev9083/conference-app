import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../router/app_route_bloc.dart';
import '../../utils/screen.dart';
import 'home_page.dart';
import 'router/home_route_bloc.dart';

class HomeScreen extends Screen {
  static const ROUTE_NAME = '/';

  const HomeScreen()
      : super(
          staticAnimation: true,
        );

  @override
  Widget createChild(final BuildContext context) {
    return BlocProvider(
      create: (final _) => HomeRouteBloc(
        appRouteBloc: AppRouteBloc.of(context),
      ),
      child: const HomePage(),
    );
  }
}
