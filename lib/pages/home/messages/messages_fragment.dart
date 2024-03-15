import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../bloc/profile_bloc.dart';
import '../../../router/app_route_bloc.dart';
import '../../../router/app_route_state.dart';
import 'bloc/messages_bloc.dart';
import 'router/messages_route_bloc.dart';
import 'users_panel.dart';

class MessagesFragment extends StatefulWidget {
  const MessagesFragment();

  @override
  _MessagesFragmentState createState() => _MessagesFragmentState();
}

class _MessagesFragmentState extends State<MessagesFragment> {
  final _keyUsersPanel = GlobalKey();
  final _keyAutoRouter = GlobalKey();

  @override
  Widget build(final BuildContext context) {
    final messageDetail = Router(
      key: _keyAutoRouter,
      routerDelegate: MessagesRouteBloc.of(context).state.routeDelegate,
    );
    final userPanel = UsersPanel(
      key: _keyUsersPanel,
    );
    return BlocProvider(
      create: (final _) => MessagesBloc(
        profileId: ProfileBloc.of(context).state!.id,
      ),
      child: Container(
        margin: const EdgeInsets.only(
          top: 18,
        ),
        child: ScreenTypeLayout.builder(
          mobile: (final _) => BlocSelector<AppRouteBloc, AppRouteState, int?>(
            selector: (final state) => state.routeConfig.whenOrNull<int?>(
              home: (final homeConfig) => homeConfig.whenOrNull<int?>(
                messages: (final messagesConfig) =>
                    messagesConfig.selectedUserId,
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
                  messageDetail,
                ],
              ],
            ),
          ),
          tablet: (final _) => Row(
            children: [
              Expanded(
                flex: 350,
                child: userPanel,
              ),
              const SizedBox(width: 18),
              Expanded(
                flex: 878,
                child: messageDetail,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
