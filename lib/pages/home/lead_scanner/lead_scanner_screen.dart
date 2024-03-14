import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../router/app_route_bloc.dart';
import '../../../utils/screen.dart';
import 'lead_scanner_fragment.dart';
import 'router/lead_scanner_route_bloc.dart';

class LeadScannerScreen extends Screen {
  static const ROUTE_NAME = 'lead-scanner';

  const LeadScannerScreen()
      : super(
          staticAnimation: true,
        );

  @override
  Widget createChild(final BuildContext context) {
    return BlocProvider(
      create: (final _) => LeadScannerRouteBloc(
        appRouteBloc: AppRouteBloc.of(context),
      ),
      child: const LeadScannerFragment(),
    );
  }
}
