import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../router/app_route_bloc.dart';
import '../../../../router/app_route_config.dart';
import '../../../../widgets/cubit.dart';
import '../../router/home_route_config.dart';
import 'lead_scanner_route_config.dart';
import 'lead_scanner_route_state.dart';

class LeadScannerRouteBloc extends WCCubit<LeadScannerRouteState> {
  final AppRouteBloc appRouteBloc;

  LeadScannerRouteBloc({
    required this.appRouteBloc,
  }) : super(LeadScannerRouteState());

  factory LeadScannerRouteBloc.of(final BuildContext context) =>
      BlocProvider.of<LeadScannerRouteBloc>(context);

  @override
  Future<void> close() {
    state.routeDelegate.dispose();
    return super.close();
  }

  void updateSelectedUserid(final int? selectedUserId) {
    appRouteBloc.updateRouteConfig(
      AppRouteConfig.home(
        homeRouteConfig: HomeRouteConfig.leadScanner(
          leadScannerRouteConfig: LeadScannerRouteConfig(
            selectedUserId: selectedUserId,
          ),
        ),
      ),
    );
  }
}
