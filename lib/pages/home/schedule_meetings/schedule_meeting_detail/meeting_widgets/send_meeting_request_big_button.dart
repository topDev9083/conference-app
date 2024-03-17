import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../../../bloc/profile_bloc.dart';
import '../../../../../flutter_i18n/translation_keys.dart';
import '../../../../../others/meeting_status_events.dart';
import '../../../../../widgets/outlined_button.dart';
import '../bloc/schedule_meeting_detail_bloc.dart';
import '../bloc/schedule_meeting_detail_state.dart';
import 'send_meeting_request_small_button.dart';

class SendMeetingRequestBigButton extends StatelessWidget {
  const SendMeetingRequestBigButton();

  @override
  Widget build(final BuildContext context) {
    return BlocBuilder<ScheduleMeetingDetailBloc, ScheduleMeetingDetailState>(
      builder: (final _, final state) => WCOutlinedButton(
        title: translate(context, _getText(context)) ?? '',
        onTap: () => SendMeetingRequestSmallButton.openTimeSlots(context),
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
    meeting.callMeetingStatusEvent(
      profileId,
      MeetingStatusEvents(
        pendingMe: () {
          titleKey = TranslationKeys
              .Schedule_Meetings_User_Detail_Update_Meeting_Request;
        },
        pendingHim: null,
        rescheduledMe: null,
        rescheduledHim: () {
          titleKey = TranslationKeys
              .Schedule_Meetings_User_Detail_Update_Rescheduled_Meeting_Request;
        },
        acceptedMe: () {
          titleKey =
              TranslationKeys.Schedule_Meetings_User_Detail_Ask_To_Reschedule;
        },
        acceptedHim: () {
          titleKey =
              TranslationKeys.Schedule_Meetings_User_Detail_Ask_To_Reschedule;
        },
        postPendingMe: () {
          titleKey = TranslationKeys
              .Schedule_Meetings_User_Detail_Update_Rescheduled_Meeting_Request;
        },
        postPendingHim: null,
        postRescheduledMe: null,
        postRescheduledHim: () {
          titleKey = TranslationKeys
              .Schedule_Meetings_User_Detail_Update_Rescheduled_Meeting_Request;
        },
        cancelledMe: () {
          titleKey = TranslationKeys
              .Schedule_Meetings_User_Detail_Send_Meeting_Request;
        },
        cancelledHim: () {
          titleKey = TranslationKeys
              .Schedule_Meetings_User_Detail_Send_Meeting_Request;
        },
        rejectedMe: null,
        rejectedHim: () {
          titleKey = TranslationKeys
              .Schedule_Meetings_User_Detail_Send_Meeting_Request;
        },
        postCancelledMe: () {
          titleKey = TranslationKeys
              .Schedule_Meetings_User_Detail_Send_Meeting_Request;
        },
        postCancelledHim: () {
          titleKey = TranslationKeys
              .Schedule_Meetings_User_Detail_Send_Meeting_Request;
        },
        postRejectedMe: () {
          titleKey = TranslationKeys
              .Schedule_Meetings_User_Detail_Send_Meeting_Request;
        },
        postRejectedHim: () {
          titleKey = TranslationKeys
              .Schedule_Meetings_User_Detail_Send_Meeting_Request;
        },
      ),
    );
    return titleKey;
  }
}
