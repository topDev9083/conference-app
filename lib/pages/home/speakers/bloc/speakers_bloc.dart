import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../models/data/session_data.dart';
import '../../../../models/response/api_response.dart';
import '../../../../models/states/api_state.dart';
import '../../../../services/session_service.dart';
import '../../../../services/user_service.dart';
import '../../../../utils/dio.dart';
import '../../../../widgets/cubit.dart';
import 'speakers_state.dart';

class SpeakersBloc extends WCCubit<SpeakersState> {
  CancelToken? _searchSpeakersCancelToken;

  SpeakersBloc() : super(SpeakersState()) {
    getSpeakers();
  }

  factory SpeakersBloc.of(final BuildContext context) =>
      BlocProvider.of<SpeakersBloc>(context);

  Future<void> getSpeakers() async {
    cancelDioToken(_searchSpeakersCancelToken);
    emit(
      state.rebuild(
        (final b) => b
          ..speakersApi.isApiInProgress = true
          ..speakersApi.error = null
          ..speakersApi.data = null,
      ),
    );
    try {
      _searchSpeakersCancelToken = CancelToken();
      final speakers =
          await userService.searchUsersByRoleAndGroupNameWithSessions(
        roleName: 'speaker',
        groupName: 'speaker',
        search: state.speakersSearch,
        cancelToken: _searchSpeakersCancelToken,
      );
      emit(state.rebuild((final b) => b.speakersApi.data = speakers));
    } catch (e) {
      if (!(e is DioException && e.type == DioExceptionType.cancel)) {
        final metaData = ApiResponse.getStrongMetaData(e);
        emit(
          state.rebuild((final b) => b.speakersApi.error = metaData.message),
        );
      }
    }
    emit(state.rebuild((final b) => b.speakersApi.isApiInProgress = false));
  }

  void updateSearch(final String search) {
    emit(state.rebuild((final b) => b.speakersSearch = search));
    getSpeakers();
  }

  void updateSession(final SessionData session) {
    final speakers = state.speakersApi.data;
    if (speakers == null) {
      return;
    }
    emit(
      state.rebuild(
        (final b) => b.speakersApi.data = speakers.rebuild(
          (final bSpeakers) {
            for (var i = 0; i < bSpeakers.length; i++) {
              bSpeakers[i] = bSpeakers[i].rebuild((final bSpeaker) {
                for (var j = 0; j < bSpeaker.sessions.length; j++) {
                  if (bSpeaker.sessions[j].id == session.id) {
                    bSpeaker.sessions[j] = session;
                  }
                }
              });
            }
          },
        ),
      ),
    );
  }

  Future<void> addOrRemoveAgenda(
    final int sessionId, {
    final bool addToAgenda = true,
  }) async {
    var apiState = state.addToAgendaApi[sessionId] ?? ApiState<SessionData>();
    apiState = apiState.rebuild(
      (final b) => b
        ..isApiInProgress = true
        ..error = null
        ..message = null,
    );
    emit(
      state.rebuild((final b) {
        b.addToAgendaApi[sessionId] = apiState;
      }),
    );

    try {
      SessionData session;
      if (addToAgenda) {
        session = await sessionService.addSessionToAgenda(sessionId);
      } else {
        session = await sessionService.removeSessionToAgenda(sessionId);
      }
      apiState = apiState.rebuild((final b) => b..message = 'success');
      updateSession(session);
    } catch (e) {
      final metaData = ApiResponse.getStrongMetaData(e);
      apiState = apiState.rebuild((final b) => b..error = metaData.message);
    }
    apiState = apiState.rebuild((final b) => b..isApiInProgress = false);
    emit(
      state.rebuild((final b) {
        b.addToAgendaApi[sessionId] = apiState;
      }),
    );

    apiState = apiState.rebuild((final b) => b..error = null);
    emit(
      state.rebuild((final b) {
        b.addToAgendaApi[sessionId] = apiState;
      }),
    );
  }
}
