import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/colors.dart';
import '../../../models/states/api_state.dart';
import '../../../router/app_route_bloc.dart';
import '../../../router/app_route_state.dart';
import '../../../utils/share_utils.dart';
import '../../../utils/responsive_utils.dart';
import '../../../widgets/bloc_listener.dart';
import 'bloc/lead_scanner_bloc.dart';
import 'bloc/lead_scanner_state.dart';
import 'router/lead_scanner_route_bloc.dart';
import 'users_panel.dart';

class LeadScannerFragment extends StatefulWidget {
  const LeadScannerFragment();

  @override
  _LeadScannerFragmentState createState() => _LeadScannerFragmentState();
}

class _LeadScannerFragmentState extends State<LeadScannerFragment> {
  final _keyUsersPanel = GlobalKey();
  final _keyAutoRouter = GlobalKey();

  @override
  Widget build(final BuildContext context) {
    final userPanel = UsersPanel(
      key: _keyUsersPanel,
    );
    final leadScannerDetail = Router(
      key: _keyAutoRouter,
      routerDelegate: LeadScannerRouteBloc.of(context).state.routeDelegate,
    );
    return BlocProvider(
      create: (final _) => LeadScannerBloc(),
      child: MultiBlocListener(
        listeners: [
          ErrorBlocListener<LeadScannerBloc, LeadScannerState>(
            errorWhen: (final state) => state.addUserApi.error,
          ),
          ErrorBlocListener<LeadScannerBloc, LeadScannerState>(
            errorWhen: (final state) {
              for (final key in state.deleteUserApi.keys) {
                final apiState = state.deleteUserApi[key] ?? ApiState<void>();
                if (apiState.error != null) {
                  return apiState.error;
                }
              }
              return null;
            },
          ),
          ErrorBlocListener<LeadScannerBloc, LeadScannerState>(
            errorWhen: (final state) => state.getUsersCsvApi.error,
          ),
          ActionBlocListener<LeadScannerBloc, LeadScannerState>(
            when: (final state) => state.addUserApi.data,
            listener: (final _, final state) {
              LeadScannerRouteBloc.of(context)
                  .updateSelectedUserid(state.addUserApi.data!.id);
            },
          ),
          ActionBlocListener<LeadScannerBloc, LeadScannerState>(
            when: (final state) => state.getUsersCsvApi.data,
            listener: (final _, final state) =>
                ShareUtils.shareCSV(state.getUsersCsvApi.data!),
          ),
        ],
        child: Container(
          color: WCColors.grey_f7,
          child: Column(
            children: [
              const SizedBox(height: 12),
              Expanded(
                child: ScreenType.of(context).isMobile
                    ? BlocSelector<AppRouteBloc, AppRouteState, int?>(
                        selector: (final state) =>
                            state.routeConfig.whenOrNull<int?>(
                          home: (final home) => home.whenOrNull<int?>(
                            leadScanner: (final ls) => ls.selectedUserId,
                          ),
                        ),
                        builder: (final _, final selectedUserId) => Stack(
                          children: [
                            Visibility(
                              visible: selectedUserId == null,
                              maintainState: true,
                              child: userPanel,
                            ),
                            if (selectedUserId != null) ...[
                              leadScannerDetail,
                            ],
                          ],
                        ),
                      )
                    : Row(
                        children: [
                          Expanded(
                            flex: 350,
                            child: userPanel,
                          ),
                          const SizedBox(width: 18),
                          Expanded(
                            flex: 878,
                            child: leadScannerDetail,
                          ),
                        ],
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
