import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../flutter_i18n/translation_keys.dart';
import '../../../models/enums/meeting_status.dart';
import '../../../widgets/tab_bar.dart';
import 'bloc/meeting_management_bloc.dart';
import 'bloc/meeting_management_state.dart';

class MeetingManagementTabs extends StatelessWidget {
  const MeetingManagementTabs();

  @override
  Widget build(final BuildContext context) {
    return BlocBuilder<MeetingManagementBloc, MeetingManagementState>(
      builder: (final _, final state) => WCTabBar(
        items: [
          TabData(
            translate(context, TranslationKeys.Meeting_Management_Pending)!,
            isSelected: state.selectedMeetingStatus == MeetingStatus.pending,
            onTap: () => MeetingManagementBloc.of(context)
                .updateSelectedMeetingStatus(MeetingStatus.pending),
          ),
          TabData(
            translate(context, TranslationKeys.Meeting_Management_Accepted)!,
            isSelected: state.selectedMeetingStatus == MeetingStatus.accepted,
            onTap: () => MeetingManagementBloc.of(context)
                .updateSelectedMeetingStatus(MeetingStatus.accepted),
          ),
          TabData(
            translate(context, TranslationKeys.Meeting_Management_Cancelled)!,
            isSelected: state.selectedMeetingStatus == MeetingStatus.cancelled,
            onTap: () => MeetingManagementBloc.of(context)
                .updateSelectedMeetingStatus(MeetingStatus.cancelled),
          ),
        ],
      ),
    );
  }
}
