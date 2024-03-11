import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../extensions/date_time.dart';
import '../../../widgets/connection_information.dart';
import '../../../widgets/time_zone_bloc_builder.dart';
import 'bloc/sessions_bloc.dart';
import 'bloc/sessions_state.dart';
import 'session_item.dart';

class SessionsList extends StatelessWidget {
  const SessionsList();

  @override
  Widget build(final BuildContext context) {
    return BlocBuilder<SessionsBloc, SessionsState>(
      builder: (final _, final sessionState) =>
          sessionState.sessionsApi.data == null
              ? Center(
                  child: ConnectionInformation(
                    error: sessionState.sessionsApi.error,
                    onRetry: SessionsBloc.of(context).getSessions,
                  ),
                )
              : TimeZoneBlocBuilder(
                  builder: (final timeZone) => ListView.builder(
                    itemBuilder: (final _, final index) {
                      final sessions = sessionState.sessionsApi.data!;
                      return SessionItem(
                        sessions[index],
                        showHeader: index == 0 ||
                            !sessions[index - 1].startDate.isAtSameDateAs(
                                  sessions[index].startDate,
                                  zone: timeZone.zone,
                                ),
                      );
                    },
                    itemCount: sessionState.sessionsApi.data!.length,
                  ),
                ),
    );
  }
}
