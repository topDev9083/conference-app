import 'package:flutter/material.dart';

import '../../../flutter_i18n/translation_keys.dart';
import '../../../models/data/session_data.dart';
import '../../../models/states/api_state.dart';
import '../../../widgets/ink_well.dart';
import '../../../widgets/session_basic_info_item.dart';
import '../sessions/session_detail/session_detail_drawer.dart';
import 'bloc/my_agenda_bloc.dart';
import 'time.dart';

class SessionItem extends StatelessWidget {
  final SessionData session;

  const SessionItem(this.session);

  @override
  Widget build(final BuildContext context) {
    return WCInkWell(
      padding: const EdgeInsets.symmetric(vertical: 25),
      hoverColor: Theme.of(context).primaryColor.withOpacity(0.05),
      onTap: () => SessionDetailDrawer.open(
        context,
        session: session,
        onSessionChanged:
            MyAgendaBloc.of(context).addOrRemoveSessionViaMyAgenda,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Transform.translate(
            offset: const Offset(0, 1.5),
            child: Time(
              start: session.startDate,
              end: session.endDate,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  translate(context, TranslationKeys.My_Agenda_Session)!,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 11),
                SessionBasicInfoItem(
                  session: session,
                  addToAgendaState: MyAgendaBloc.of(context)
                          .state
                          .removeFromAgendaApi[session.id] ??
                      ApiState<void>(),
                  onStarTapped: () =>
                      MyAgendaBloc.of(context).removeFromAgenda(session.id),
                ),
              ],
            ),
          ),
          const SizedBox(width: 28),
        ],
      ),
    );
  }
}
