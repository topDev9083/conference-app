import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/event_bloc.dart';
import '../../../bloc/event_code_bloc.dart';
import '../../../flutter_i18n/translation_keys.dart';
import '../../../models/response/api_response.dart';
import '../../../services/event_service.dart';
import '../../../widgets/cubit.dart';
import 'select_event_code_state.dart';

class SelectEventCodeBloc extends WCCubit<SelectEventCodeState> {
  final EventBloc eventBloc;
  final EventCodeBloc eventCodeBloc;

  SelectEventCodeBloc({
    required this.eventBloc,
    required this.eventCodeBloc,
  }) : super(SelectEventCodeState());

  factory SelectEventCodeBloc.of(final BuildContext context) =>
      BlocProvider.of<SelectEventCodeBloc>(context);

  void updateEventCode(final String eventCode) {
    emit(
      state.rebuild(
        (final b) => b
          ..eventCode = eventCode
          ..getEventApi.error = null,
      ),
    );
  }

  Future<void> getEventByCode() async {
    emit(
      state.rebuild(
        (final b) => b.getEventApi
          ..isApiInProgress = true
          ..error = null,
      ),
    );
    try {
      final event = await eventService.getEventByCode(state.eventCode);
      emit(
        state.rebuild(
          (final b) => b.getEventApi.data = event,
        ),
      );
      eventCodeBloc.updateEventCode(event.code);
      eventBloc.updateEvent(event);
    } catch (e) {
      final metaData = ApiResponse.getStrongMetaData(e);
      emit(
        state.rebuild(
          (final b) {
            if (metaData.status == 404) {
              b.getEventApi.error =
                  TranslationKeys.Select_Event_Code_Error_Event_Not_Found;
            } else {
              b.getEventApi.error = metaData.toString();
            }
          },
        ),
      );
    }
    emit(
      state.rebuild(
        (final b) => b.getEventApi.isApiInProgress = false,
      ),
    );
  }
}
