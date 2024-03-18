import 'package:flutter/material.dart';

import '../../../extensions/date_time.dart';
import '../../../models/data/session_data.dart';
import '../../../models/states/api_state.dart';
import '../../../widgets/ink_well.dart';
import '../../../widgets/session_basic_info_item.dart';
import '../../../widgets/time_zone_bloc_builder.dart';
import 'bloc/sessions_bloc.dart';
import 'session_detail/session_detail_drawer.dart';

class SessionItem extends StatelessWidget {
  final SessionData session;
  final bool showHeader;

  const SessionItem(
    this.session, {
    this.showHeader = false,
  });

  @override
  Widget build(final BuildContext context) {
    final state = SessionsBloc.of(context).state;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showHeader) ...[
          const SizedBox(height: 14),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 27,
            ),
            child: TimeZoneBlocBuilder(
              builder: (final timeZone) => Text(
                session.startDate
                    .format(format: 'EEE, dd MMM yyyy', timeZone: timeZone),
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
        const SizedBox(height: 14),
        Container(
          color: Colors.white,
          child: WCInkWell(
            hoverColor: Theme.of(context).primaryColor.withOpacity(0.05),
            padding: const EdgeInsets.symmetric(
              horizontal: 28,
              vertical: 23,
            ),
            onTap: () => _openSessionDetail(context),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TimeZoneBlocBuilder(
                  builder: (final timeZone) => Text(
                    '${session.startDate.format(
                      format: 'hh:mm a',
                      timeZone: timeZone,
                    )}-${session.endDate.format(
                      format: 'hh:mm a',
                      timeZone: timeZone,
                    )}',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 12,
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: SessionBasicInfoItem(
                    addToAgendaState:
                        state.addToAgendaApi[session.id] ?? ApiState<void>(),
                    session: session,
                    onStarTapped: () =>
                        _addOrRemoveFromAgenda(context, session),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _openSessionDetail(final BuildContext context) {
    SessionDetailDrawer.open(
      context,
      session: session,
      onSessionChanged: SessionsBloc.of(context).updateSession,
    );
  }

  void _addOrRemoveFromAgenda(
    final BuildContext context,
    final SessionData session,
  ) {
    final bloc = SessionsBloc.of(context);
    bloc.addOrRemoveAgenda(
      session.id,
      addToAgenda: !session.isInMyAgenda!,
    );
  }
}
