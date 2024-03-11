import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../models/data/session_data.dart';
import '../../../../models/response/api_response.dart';
import '../../../../models/states/api_state.dart';
import '../../../../services/session_service.dart';
import '../../../../utils/dio.dart';
import '../../../../widgets/cubit.dart';
import 'sessions_state.dart';

class SessionsBloc extends WCCubit<SessionsState> {
  CancelToken? _sessionsCancelToken;

  SessionsBloc() : super(SessionsState()) {
    getSessions();
  }

  factory SessionsBloc.of(final BuildContext context) =>
      BlocProvider.of<SessionsBloc>(context);

  Future<void> getSessions() async {
    cancelDioToken(_sessionsCancelToken);
    emit(
      state.rebuild(
        (final b) => b
          ..sessionsApi.isApiInProgress = false
          ..sessionsApi.error = null
          ..sessionsApi.data = null,
      ),
    );
    try {
      _sessionsCancelToken = CancelToken();
      final sessions = await sessionService.getSessions(
        startDateTimeOfStartDate:
            state.startDateTimeOfStartDate?.millisecondsSinceEpoch,
        endDateTimeOfStartDate:
            state.endDateTimeOfStartDate?.millisecondsSinceEpoch,
        cancelToken: _sessionsCancelToken,
      );
      emit(state.rebuild((final b) => b.sessionsApi.data = sessions));
    } catch (e) {
      if (!(e is DioException && e.type == DioExceptionType.cancel)) {
        final metaData = ApiResponse.getStrongMetaData(e);
        emit(
          state.rebuild((final b) => b.sessionsApi.error = metaData.message),
        );
      }
    }
    emit(state.rebuild((final b) => b.sessionsApi.isApiInProgress = false));
  }

  void updateSelectedDate(final DateTime? selectedDate) {
    emit(
      state.rebuild(
        (final b) => b
          ..startDateTimeOfStartDate = selectedDate
          ..endDateTimeOfStartDate = selectedDate
              ?.add(const Duration(days: 1))
              .subtract(const Duration(seconds: 1)),
      ),
    );
    getSessions();
  }

  void updateSession(final SessionData session) {
    final index =
        state.sessionsApi.data!.indexWhere((final s) => s.id == session.id);
    if (index.isNegative) {
      return;
    }
    emit(
      state.rebuild(
        (final b) => b.sessionsApi.data = state.sessionsApi.data!.rebuild(
          (final bData) => bData[index] = session,
        ),
      ),
    );
  }

  Future<void> addOrRemoveAgenda(
    final int sessionId, {
    final bool addToAgenda = true,
  }) async {
    emit(
      state.rebuild((final b) {
        b.addToAgendaApi[sessionId] =
            (state.addToAgendaApi[sessionId] ?? ApiState<SessionData>())
                .rebuild(
          (final b) => b
            ..isApiInProgress = true
            ..error = null
            ..message = null,
        );
      }),
    );

    try {
      SessionData session;
      if (addToAgenda) {
        session = await sessionService.addSessionToAgenda(sessionId);
      } else {
        session = await sessionService.removeSessionToAgenda(sessionId);
      }
      emit(
        state.rebuild(
          (final b) => b.addToAgendaApi[sessionId] = state
              .addToAgendaApi[sessionId]!
              .rebuild((final b) => b.message = 'success'),
        ),
      );
      updateSession(session);
    } catch (e) {
      final metaData = ApiResponse.getStrongMetaData(e);
      emit(
        state.rebuild(
          (final b) => b.addToAgendaApi[sessionId] = state
              .addToAgendaApi[sessionId]!
              .rebuild((final b) => b.error = metaData.message),
        ),
      );
    }
    emit(
      state.rebuild(
        (final b) => b.addToAgendaApi[sessionId] = state
            .addToAgendaApi[sessionId]!
            .rebuild((final b) => b.isApiInProgress = false),
      ),
    );
  }
}
