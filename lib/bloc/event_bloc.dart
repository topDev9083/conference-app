import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:logging/logging.dart';

import '../models/data/event_data.dart';
import '../models/response/api_response.dart';
import '../services/event_service.dart';
import '../services/shared_preferences_service.dart';
import '../widgets/cubit.dart';
import 'event_code_bloc.dart';
import 'state/event_state.dart';

final _logger = Logger('event_bloc.dart');

class EventBloc extends WCCubit<EventState> with HydratedMixin {
  final EventCodeBloc eventCodeBloc;

  EventBloc({
    required this.eventCodeBloc,
  }) : super(EventState()) {
    if (eventCodeBloc.state != null) {
      getEvent();
    }
  }

  factory EventBloc.of(final BuildContext context) =>
      BlocProvider.of<EventBloc>(context);

  Future<void> getEvent() async {
    emit(
      state.rebuild(
        (final b) => b.getEventApi
          ..isApiInProgress = true
          ..error = null,
      ),
    );
    try {
      final event = await eventService.getEventByCode(eventCodeBloc.state!);
      emit(
        state.rebuild(
          (final b) => b.getEventApi.data = event,
        ),
      );
    } catch (e) {
      final metaData = ApiResponse.getStrongMetaData(e);
      emit(
        state.rebuild(
          (final b) => b.getEventApi.error = metaData.message,
        ),
      );
    }
    emit(
      state.rebuild(
        (final b) => b.getEventApi.isApiInProgress = false,
      ),
    );
  }

  void updateEvent(final EventData event) {
    emit(
      state.rebuild(
        (final b) => b.getEventApi.data = event,
      ),
    );
  }

  BuiltList<DateTime> getEventDates() {
    final event = state.getEventApi.data;
    final dates = ListBuilder<DateTime>();
    if (event == null) {
      return dates.build();
    }
    var sDate = event.startDate;
    final eDate = event.endDate;
    while (sDate.millisecondsSinceEpoch <= eDate.millisecondsSinceEpoch) {
      dates.add(sDate);
      sDate = sDate.add(const Duration(days: 1));
    }
    return dates.build();
  }

  void resetAccordingToEventCode() {
    if (eventCodeBloc.state != state.getEventApi.data?.code) {
      emit(EventState());
    }
    if (eventCodeBloc.state != null) {
      getEvent();
    }
  }

  @override
  EventState fromJson(final Map<String, dynamic> json) {
    if (eventCodeBloc.state == null) {
      return EventState();
    }
    try {
      EventData? event;
      if (json.containsKey('event')) {
        event = EventData.fromDynamic(
          json['event'],
        );
      }
      event ??= sharedPreferencesService.getEvent();
      return EventState(
        (final b) => b.getEventApi.data = event,
      );
    } catch (e) {
      _logger.severe('fromJson: $e');
    }
    return EventState();
  }

  @override
  Map<String, dynamic>? toJson(final EventState state) {
    final event = state.getEventApi.data;
    if (event != null) {
      return {
        'event': event.toDynamic(),
      };
    }
    return {};
  }
}
