import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../flutter_i18n/translation_keys.dart';
import '../../../models/enums/meeting_status.dart';
import '../../../widgets/checkbox_tile.dart';
import 'bloc/schedule_meetings_bloc.dart';
import 'bloc/schedule_meetings_state.dart';

class MeetingStatusFilterContainer extends StatelessWidget {
  final ScheduleMeetingsBloc bloc;

  const MeetingStatusFilterContainer(this.bloc);

  @override
  Widget build(final BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _MSCheckbox(
            titleKey:
                TranslationKeys.Schedule_Meetings_Filter_Panel_Pending_Requests,
            status: MeetingStatus.pending,
          ),
          _MSCheckbox(
            titleKey: TranslationKeys
                .Schedule_Meetings_Filter_Panel_Confirmed_Request,
            status: MeetingStatus.accepted,
          ),
          _MSCheckbox(
            titleKey:
                TranslationKeys.Schedule_Meetings_Filter_Panel_Canceled_Request,
            status: MeetingStatus.cancelled,
          ),
        ],
      ),
    );
  }
}

class _MSCheckbox extends StatelessWidget {
  final String titleKey;
  final MeetingStatus status;

  const _MSCheckbox({
    required this.titleKey,
    required this.status,
  });

  @override
  Widget build(final BuildContext context) {
    final bloc = ScheduleMeetingsBloc.of(context);
    return BlocBuilder<ScheduleMeetingsBloc, ScheduleMeetingsState>(
      builder: (final _, final state) => WCCheckboxTile(
        title: translate(context, titleKey)!,
        onChanged: (final isChecked) => isChecked
            ? bloc.addMeetingStatus(status)
            : bloc.removeMeetingStatus(status),
        value: bloc.state.selectedMeetingStatues.contains(status),
      ),
    );
  }
}
