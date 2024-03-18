import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../bloc/home_drawer_bloc.dart';
import '../../../../models/data/session_data.dart';
import '../../../../widgets/dialogs.dart';
import '../../../../widgets/full_screen_drawer.dart';
import 'bloc/session_detail_bloc.dart';
import 'bloc/session_detail_state.dart';
import 'session_detail_list.dart';

class SessionDetailDrawer extends StatelessWidget {
  final SessionData session;
  final ValueChanged<SessionData>? onSessionChanged;

  static void open(
    final BuildContext context, {
    required final SessionData session,
    final ValueChanged<SessionData>? onSessionChanged,
  }) {
    HomeDrawerBloc.of(context).updateEndDrawerWidget(
      SessionDetailDrawer._(
        session: session,
        onSessionChanged: onSessionChanged,
      ),
    );
    Scaffold.of(context).openEndDrawer();
  }

  const SessionDetailDrawer._({
    required this.session,
    this.onSessionChanged,
  });

  @override
  Widget build(final BuildContext context) {
    return BlocProvider(
      create: (final _) => SessionDetailBloc(
        session: session,
        onSessionChanged: onSessionChanged,
      ),
      child: BlocListener<SessionDetailBloc, SessionDetailState>(
        listenWhen: (final prev, final next) =>
            prev.addToAgendaApi.error == null &&
            next.addToAgendaApi.error != null,
        listener: (final _, final state) => WCDialog.showError(
          context,
          subtitle: state.addToAgendaApi.error,
        ),
        child: const FullScreenDrawer(
          width: 361,
          child: SessionDetailList(),
        ),
      ),
    );
  }
}
