import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/states/api_state.dart';
import '../../../widgets/dialogs.dart';
import 'bloc/sessions_bloc.dart';
import 'bloc/sessions_state.dart';
import 'session_tabs.dart';
import 'sessions_list.dart';

class SessionsFragment extends StatelessWidget {
  static const ROUTE_NAME = 'sessions';

  const SessionsFragment();

  @override
  Widget build(final BuildContext context) {
    return BlocProvider(
      create: (final _) => SessionsBloc(),
      child: BlocListener<SessionsBloc, SessionsState>(
        listenWhen: (final prev, final next) {
          var hasError = false;
          next.addToAgendaApi.forEach((final sessionId, final nextApiState) {
            final prevApiState =
                prev.addToAgendaApi[sessionId] ?? ApiState<void>();
            if (prevApiState.error == null && nextApiState.error != null) {
              hasError = true;
            }
          });
          return hasError;
        },
        listener: (final _, final state) {
          state.addToAgendaApi.forEach((final sessionId, final apiState) {
            if (apiState.error != null) {
              WCDialog.showError(context, subtitle: apiState.error);
            }
          });
        },
        child: const Column(
          children: [
            SizedBox(height: 17),
            SessionTabs(),
            Expanded(
              child: SessionsList(),
            ),
          ],
        ),
      ),
    );
  }
}
