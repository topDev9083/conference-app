import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:tuple/tuple.dart';

import '../../../../../bloc/profile_bloc.dart';
import '../../../../../core/colors.dart';
import '../../../../../flutter_i18n/translation_keys.dart';
import '../../../../../models/enums/meeting_status.dart';
import '../../../../../others/meeting_status_events.dart';
import '../../../../../widgets/outlined_button.dart';
import '../bloc/schedule_meeting_detail_bloc.dart';
import '../bloc/schedule_meeting_detail_state.dart';
import '../meeting_update_message_dialog.dart';

class CancelRejectMeetingButton extends StatelessWidget {
  const CancelRejectMeetingButton();

  @override
  Widget build(final BuildContext context) {
    final bloc = ScheduleMeetingDetailBloc.of(context);
    return BlocBuilder<ScheduleMeetingDetailBloc, ScheduleMeetingDetailState>(
      builder: (final _, final state) {
        final tuple = _getText(context);
        return WCOutlinedButton(
          title: translate(context, tuple!.item1),
          backgroundColor: Colors.white,
          borderColor: WCColors.grey_dd,
          textColor: WCColors.black_09,
          showLoader: state.meetingRequestApi.isApiInProgress,
          onTap: () => MeetingUpdateMessageDialog.show(
            context,
            titleKey: tuple.item1,
            meetingStatus: tuple.item2,
            bloc: bloc,
          ),
          type: getValueForScreenType(
            context: context,
            mobile: WCOutlinedButtonType.bigV,
            tablet: WCOutlinedButtonType.bigA,
          ),
        );
      },
    );
  }

  static bool shouldVisible(final BuildContext context) =>
      _getText(context) != null;

  static Tuple2<String, MeetingStatus>? _getText(final BuildContext context) {
    final profileId = ProfileBloc.of(context).state!.id;
    final meeting =
        ScheduleMeetingDetailBloc.of(context).state.userApi.data!.meeting!;
    String? titleKey;
    MeetingStatus? status;
    meeting.callMeetingStatusEvent(
      profileId,
      MeetingStatusEvents(
        pendingMe: () {
          titleKey = TranslationKeys
              .Schedule_Meetings_User_Detail_Cancel_Meeting_Request;
          status = MeetingStatus.cancelled;
        },
        pendingHim: () {
          titleKey = TranslationKeys.Schedule_Meetings_User_Detail_Decline;
          status = MeetingStatus.rejected;
        },
        rescheduledMe: () {
          titleKey = TranslationKeys
              .Schedule_Meetings_User_Detail_Cancel_Meeting_Request;
          status = MeetingStatus.cancelled;
        },
        rescheduledHim: () {
          titleKey = TranslationKeys.Schedule_Meetings_User_Detail_Decline;
          status = MeetingStatus.rejected;
        },
        acceptedMe: () {
          titleKey =
              TranslationKeys.Schedule_Meetings_User_Detail_Cancel_Meeting;
          status = MeetingStatus.postCancelled;
        },
        acceptedHim: () {
          titleKey =
              TranslationKeys.Schedule_Meetings_User_Detail_Cancel_Meeting;
          status = MeetingStatus.postRejected;
        },
        postPendingMe: () {
          titleKey =
              TranslationKeys.Schedule_Meetings_User_Detail_Cancel_Meeting;
          status = MeetingStatus.postCancelled;
        },
        postPendingHim: () {
          titleKey =
              TranslationKeys.Schedule_Meetings_User_Detail_Cancel_Meeting;
          status = MeetingStatus.postRejected;
        },
        postRescheduledMe: () {
          titleKey =
              TranslationKeys.Schedule_Meetings_User_Detail_Cancel_Meeting;
          status = MeetingStatus.postCancelled;
        },
        postRescheduledHim: () {
          titleKey =
              TranslationKeys.Schedule_Meetings_User_Detail_Cancel_Meeting;
          status = MeetingStatus.postRejected;
        },
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
    return titleKey == null || status == null
        ? null
        : Tuple2(titleKey!, status!);
  }
}
