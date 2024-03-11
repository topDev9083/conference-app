import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../widgets/tab_bar.dart';
import 'bloc/sessions_bloc.dart';
import 'bloc/sessions_state.dart';

class SessionTabs extends StatelessWidget {
  const SessionTabs();

  @override
  Widget build(final BuildContext context) {
    final sessionsBloc = SessionsBloc.of(context);
    return BlocBuilder<SessionsBloc, SessionsState>(
      builder: (final _, final sessionState) => EventTabBar(
        selectedDate: sessionState.startDateTimeOfStartDate,
        onTabSelected: sessionsBloc.updateSelectedDate,
      ),
    );
  }
}
