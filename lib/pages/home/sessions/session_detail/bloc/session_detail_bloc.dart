import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../models/data/session_data.dart';
import '../../../../../models/response/api_response.dart';
import '../../../../../services/session_service.dart';
import '../../../../../widgets/cubit.dart';
import 'session_detail_state.dart';

class SessionDetailBloc extends WCCubit<SessionDetailState> {
  final ValueChanged<SessionData>? onSessionChanged;

  SessionDetailBloc({
    required final SessionData session,
    this.onSessionChanged,
  }) : super(SessionDetailState((final b) => b.session.replace(session)));

  factory SessionDetailBloc.of(final BuildContext context) =>
      BlocProvider.of<SessionDetailBloc>(context);

  Future<void> addOrRemoveAgenda() async {
    emit(
      state.rebuild(
        (final b) => b
          ..addToAgendaApi.isApiInProgress = true
          ..addToAgendaApi.error = null,
      ),
    );

    try {
      SessionData session;
      if (state.session.isInMyAgenda!) {
        session = await sessionService.removeSessionToAgenda(state.session.id);
      } else {
        session = await sessionService.addSessionToAgenda(state.session.id);
      }
      emit(state.rebuild((final b) => b.session = session.toBuilder()));
      onSessionChanged?.call(session);
    } catch (e) {
      final metaData = ApiResponse.getStrongMetaData(e);
      emit(
        state.rebuild((final b) => b.addToAgendaApi.error = metaData.message),
      );
    }
    emit(state.rebuild((final b) => b.addToAgendaApi.isApiInProgress = false));
  }
}
