import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../../../bloc/home_drawer_bloc.dart';
import '../../../../../bloc/profile_bloc.dart';
import '../../../../../flutter_i18n/translation_keys.dart';
import '../../../../../others/meeting_status_events.dart';
import '../../../../../widgets/outlined_button.dart';
import '../bloc/schedule_meeting_detail_bloc.dart';
import '../bloc/schedule_meeting_detail_state.dart';
import '../time_slots.dart';

class AcceptMeetingRequestButton extends StatelessWidget {
  const AcceptMeetingRequestButton();

  @override
  Widget build(final BuildContext context) {
    return BlocBuilder<ScheduleMeetingDetailBloc, ScheduleMeetingDetailState>(
      builder: (final _, final state) => WCOutlinedButton(
        title: translate(
              context,
              _getText(context),
            ) ??
            '',
        onTap: () => _openTimeSlots(context),
        type: getValueForScreenType(
          context: context,
          mobile: WCOutlinedButtonType.bigV,
          tablet: WCOutlinedButtonType.bigA,
        ),
      ),
    );
  }

  static bool shouldVisible(final BuildContext context) =>
      _getText(context) != null;

  static String? _getText(final BuildContext context) {
    final profileId = ProfileBloc.of(context).state!.id;
    final meeting =
        ScheduleMeetingDetailBloc.of(context).state.userApi.data!.meeting!;
    String? titleKey;
    void fnTitleKey() =>
        titleKey = TranslationKeys.Schedule_Meetings_User_Detail_View;

    meeting.callMeetingStatusEvent(
      profileId,
      MeetingStatusEvents(
        pendingMe: null,
        pendingHim: fnTitleKey,
        rescheduledMe: fnTitleKey,
        rescheduledHim: null,
        acceptedMe: null,
        acceptedHim: null,
        postPendingMe: null,
        postPendingHim: fnTitleKey,
        postRescheduledMe: fnTitleKey,
        postRescheduledHim: null,
        cancelledMe: null,
        cancelledHim: null,
        rejectedMe: null,
        rejectedHim: null,
        postCancelledMe: null,
        postCancelledHim: null,
        postRejectedMe: null,
        postRejectedHim: null,
      ),
    );
    return titleKey;
  }

  void _openTimeSlots(final BuildContext context) {
    HomeDrawerBloc.of(context).updateEndDrawerWidget(
      TimeSlots(
        bloc: ScheduleMeetingDetailBloc.of(context),
        isToAccept: true,
      ),
    );
    Scaffold.of(context).openEndDrawer();
  }
}
