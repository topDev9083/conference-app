import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/event_bloc.dart';
import '../../../models/states/api_state.dart';
import '../../../widgets/dialogs.dart';
import 'bloc/my_agenda_bloc.dart';
import 'bloc/my_agenda_state.dart';
import 'my_agenda_list.dart';
import 'my_agenda_tabs.dart';

class MyAgendaFragment extends StatelessWidget {
  const MyAgendaFragment();

  @override
  Widget build(final BuildContext context) {
    return BlocProvider(
      create: (final _) => MyAgendaBloc(
        eventBloc: EventBloc.of(context),
      ),
      child: BlocListener<MyAgendaBloc, MyAgendaState>(
        listenWhen: (final prev, final next) {
          var hasError = false;
          next.removeFromAgendaApi
              .forEach((final sessionId, final nextApiState) {
            final prevApiState =
                prev.removeFromAgendaApi[sessionId] ?? ApiState<void>();
            if (prevApiState.error == null && nextApiState.error != null) {
              hasError = true;
            }
          });
          return hasError;
        },
        listener: (final _, final state) {
          state.removeFromAgendaApi.forEach((final sessionId, final apiState) {
            if (apiState.error != null) {
              WCDialog.showError(context, subtitle: apiState.error);
            }
          });
        },
        child: const Column(
          children: [
            SizedBox(height: 17),
            MyAgendaTabs(),
            Expanded(
              child: MyAgendaList(),
            ),
          ],
        ),
      ),
    );
  }
}
