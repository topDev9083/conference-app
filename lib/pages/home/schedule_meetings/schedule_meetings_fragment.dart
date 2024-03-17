import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/colors.dart';
import '../../../router/app_route_bloc.dart';
import '../../../router/app_route_state.dart';
import '../../../utils/responsive_utils.dart';
import 'bloc/schedule_meetings_bloc.dart';
import 'router/schedule_meetings_route_bloc.dart';
import 'schedule_meetings_filter_panel.dart';
import 'users_panel.dart';

class ScheduleMeetingsFragment extends StatefulWidget {
  const ScheduleMeetingsFragment();

  @override
  _ScheduleMeetingsFragmentState createState() =>
      _ScheduleMeetingsFragmentState();
}

class _ScheduleMeetingsFragmentState extends State<ScheduleMeetingsFragment> {
  final _keyUsersPanel = GlobalKey();
  final _keyAutoRouter = GlobalKey();

  @override
  Widget build(final BuildContext context) {
    final usersPanel = UsersPanel(
      key: _keyUsersPanel,
    );
    final scheduleMeetingDetail = Router(
      key: _keyAutoRouter,
      routerDelegate: ScheduleMeetingsRouteBloc.of(context).state.routeDelegate,
    );
    return BlocProvider(
      create: (final _) => ScheduleMeetingsBloc(),
      child: Container(
        color: WCColors.grey_f7,
        child: Column(
          children: [
            const SizedBox(height: 12),
            const ScheduleMeetingsFilterPanel(),
            const SizedBox(height: 16),
            Expanded(
              child: ScreenType.of(context).isMobile
                  ? BlocSelector<AppRouteBloc, AppRouteState, int?>(
                      selector: (final state) =>
                          state.routeConfig.whenOrNull<int?>(
                        home: (final home) => home.whenOrNull<int?>(
                          scheduleMeetings: (final sm) => sm.selectedUserId,
                        ),
                      ),
                      builder: (final _, final selectedUserId) => Stack(
                        children: [
                          Visibility(
                            visible: selectedUserId == null,
                            maintainState: true,
                            child: usersPanel,
                          ),
                          if (selectedUserId != null) ...[
                            scheduleMeetingDetail,
                          ],
                        ],
                      ),
                    )
                  : Row(
                      children: [
                        Expanded(
                          flex: 350,
                          child: usersPanel,
                        ),
                        const SizedBox(width: 18),
                        Expanded(
                          flex: 878,
                          child: scheduleMeetingDetail,
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
