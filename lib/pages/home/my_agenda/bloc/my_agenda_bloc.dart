import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../bloc/event_bloc.dart';
import '../../../../bloc/state/event_state.dart';
import '../../../../extensions/date_time.dart';
import '../../../../models/data/agenda_combined_data.dart';
import '../../../../models/data/session_data.dart';
import '../../../../models/data/user_occupancy_data.dart';
import '../../../../models/enums/agenda_combined_type.dart';
import '../../../../models/response/api_response.dart';
import '../../../../models/states/api_state.dart';
import '../../../../services/agenda_service.dart';
import '../../../../services/session_service.dart';
import '../../../../services/user_occupancy_service.dart';
import '../../../../utils/bloc_basic_listener.dart';
import '../../../../utils/dio.dart';
import '../../../../widgets/cubit.dart';
import 'my_agenda_state.dart';

class MyAgendaBloc extends WCCubit<MyAgendaState> {
  CancelToken? _agendaCancelToken;
  EventBloc eventBloc;
  StreamSubscription? timeZoneChangedSub;

  MyAgendaBloc({
    required this.eventBloc,
  }) : super(MyAgendaState()) {
    getMyAgenda();
    timeZoneChangedSub = BlocBasicListener<EventBloc, EventState>(
      cubit: eventBloc,
      listenWhen: (final prev, final next) =>
          prev.getEventApi.data?.timeZone != next.getEventApi.data?.timeZone,
    ).listen((final state) => _setCombinedAgenda());
  }

  factory MyAgendaBloc.of(final BuildContext context) =>
      BlocProvider.of<MyAgendaBloc>(context);

  @override
  Future<void> close() {
    timeZoneChangedSub?.cancel();
    return super.close();
  }

  void updateStartDate(final DateTime? selectedDate) {
    emit(
      state.rebuild(
        (final b) => b
          ..startDateTimeOfStartDate = selectedDate
          ..endDateTimeOfStartDate = selectedDate
              ?.add(const Duration(days: 1))
              .subtract(const Duration(seconds: 1)),
      ),
    );
    getMyAgenda();
  }

  Future<void> getMyAgenda() async {
    cancelDioToken(_agendaCancelToken);
    _agendaCancelToken = CancelToken();
    emit(
      state.rebuild(
        (final b) => b
          ..getAgendaApi.isApiInProgress = true
          ..getAgendaApi.error = null
          ..getAgendaApi.data = null
          ..combinedAgendas = null,
      ),
    );

    try {
      final agenda = await agendaService.getMyAgenda(
        startDateTimeOfStartDate:
            state.startDateTimeOfStartDate?.millisecondsSinceEpoch,
        endDateTimeOfStartDate:
            state.endDateTimeOfStartDate?.millisecondsSinceEpoch,
        cancelToken: _agendaCancelToken,
      );
      emit(state.rebuild((final b) => b.getAgendaApi.data = agenda));
      _setCombinedAgenda();
    } catch (e) {
      if (!(e is DioException && e.type == DioExceptionType.cancel)) {
        final metaData = ApiResponse.getStrongMetaData(e);
        emit(
          state.rebuild((final b) => b.getAgendaApi.error = metaData.message),
        );
      }
    }
    emit(state.rebuild((final b) => b.getAgendaApi.isApiInProgress = false));
  }

  void addUserOccupancy(final UserOccupancyData userOccupancy) {
    emit(
      state.rebuild(
        (final b) => b.getAgendaApi.data = b.getAgendaApi.data!
            .rebuild((final bData) => bData.occupancies.add(userOccupancy)),
      ),
    );
    _setCombinedAgenda();
  }

  Future<void> deleteUserOccupancy(final int id) async {
    emit(
      state.rebuild(
        (final b) => b.deleteUserOccupancies[id] =
            (state.deleteUserOccupancies[id] ?? ApiState<void>()).rebuild(
          (final bApiState) => bApiState
            ..isApiInProgress = true
            ..error = null
            ..message = null,
        ),
      ),
    );
    try {
      await userOccupancyService.deleteUserOccupancyById(id);
      emit(
        state.rebuild(
          (final b) => b.getAgendaApi.data = b.getAgendaApi.data!.rebuild(
            (final bData) =>
                bData.occupancies.removeWhere((final occ) => occ.id == id),
          ),
        ),
      );
      _setCombinedAgenda();
      emit(
        state.rebuild(
          (final b) => b.deleteUserOccupancies[id] = state
              .deleteUserOccupancies[id]!
              .rebuild((final bApiState) => bApiState..message = 'done'),
        ),
      );
    } catch (e) {
      final metaData = ApiResponse.getStrongMetaData(e);
      emit(
        state.rebuild(
          (final b) => b.deleteUserOccupancies[id] =
              state.deleteUserOccupancies[id]!.rebuild(
            (final bApiState) => bApiState..error = metaData.message,
          ),
        ),
      );
    }
    emit(
      state.rebuild(
        (final b) => b.deleteUserOccupancies[id] = state
            .deleteUserOccupancies[id]!
            .rebuild((final bApiState) => bApiState..isApiInProgress = false),
      ),
    );
  }

  Future<void> removeFromAgenda(final int sessionId) async {
    emit(
      state.rebuild(
        (final b) {
          b.removeFromAgendaApi[sessionId] =
              (state.removeFromAgendaApi[sessionId] ?? ApiState<SessionData>())
                  .rebuild(
            (final b) => b
              ..isApiInProgress = true
              ..error = null
              ..message = null,
          );
        },
      ),
    );

    try {
      await sessionService.removeSessionToAgenda(sessionId);
      emit(
        state.rebuild(
          (final b) {
            b.removeFromAgendaApi[sessionId] = state
                .removeFromAgendaApi[sessionId]!
                .rebuild((final b) => b.message = 'success');
            final sessionIndex = state.getAgendaApi.data!.sessions
                .indexWhere((final session) => session.id == sessionId);
            if (sessionIndex != -1) {
              b.getAgendaApi.data = state.getAgendaApi.data!.rebuild(
                (final bData) => bData.sessions.removeAt(sessionIndex),
              );
            }
          },
        ),
      );
      _setCombinedAgenda();
    } catch (e) {
      final metaData = ApiResponse.getStrongMetaData(e);
      emit(
        state.rebuild(
          (final b) => b.removeFromAgendaApi[sessionId] = state
              .removeFromAgendaApi[sessionId]!
              .rebuild((final b) => b.error = metaData.message),
        ),
      );
    }
    emit(
      state.rebuild(
        (final b) => b.removeFromAgendaApi[sessionId] = state
            .removeFromAgendaApi[sessionId]!
            .rebuild((final b) => b.isApiInProgress = false),
      ),
    );
  }

  void addOrRemoveSessionViaMyAgenda(final SessionData session) {
    emit(
      state.rebuild((final b) {
        if (session.isInMyAgenda!) {
          b.getAgendaApi.data = state.getAgendaApi.data!
              .rebuild((final bData) => bData.sessions.add(session));
        } else {
          b.getAgendaApi.data = state.getAgendaApi.data!.rebuild(
            (final bData) => bData.sessions
                .removeWhere((final mSession) => mSession.id == session.id),
          );
        }
      }),
    );
    _setCombinedAgenda();
  }

  void _setCombinedAgenda() {
    final combinedAgenda = ListBuilder<AgendaCombinedData>();
    final agenda = state.getAgendaApi.data;
    if (agenda == null) {
      return;
    }
    for (final meeting in agenda.meetings) {
      combinedAgenda.add(
        AgendaCombinedData(
          (final b) => b
            ..type = AgendaCombinedType.meeting
            ..meeting.replace(meeting)
            ..date = meeting.timeSlotStartDate,
        ),
      );
    }
    for (final session in agenda.sessions) {
      combinedAgenda.add(
        AgendaCombinedData(
          (final b) => b
            ..type = AgendaCombinedType.session
            ..session.replace(session)
            ..date = session.startDate,
        ),
      );
    }
    for (final occupancy in agenda.occupancies) {
      combinedAgenda.add(
        AgendaCombinedData(
          (final b) => b
            ..type = AgendaCombinedType.occupancy
            ..occupancy.replace(occupancy)
            ..date = occupancy.startDate,
        ),
      );
    }
    for (final eventDate in eventBloc.getEventDates()) {
      if (state.startDateTimeOfStartDate != null &&
          !eventDate.isAtSameMomentAs(state.startDateTimeOfStartDate!)) {
        continue;
      }
      final index = combinedAgenda.build().indexWhere(
            (final ca) => ca.date.isAtSameDateAs(
              eventDate,
              zone: eventBloc.state.getEventApi.data?.timeZone?.zone,
            ),
          );
      if (!index.isNegative) {
        continue;
      }
      combinedAgenda.add(
        AgendaCombinedData(
          (final b) => b
            ..type = AgendaCombinedType.none
            ..date = eventDate,
        ),
      );
    }
    combinedAgenda.sort((final a, final b) => a.date.compareTo(b.date));
    emit(state.rebuild((final b) => b.combinedAgendas = combinedAgenda));
  }
}
