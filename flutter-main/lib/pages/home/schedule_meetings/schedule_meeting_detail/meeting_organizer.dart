import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../../bloc/profile_bloc.dart';
import '../../../../extensions/date_time.dart';
import '../../../../flutter_i18n/translation_keys.dart';
import '../../../../models/enums/meeting_status.dart';
import '../../../../utils/color_utils.dart';
import '../../../../widgets/meeting_chip.dart';
import '../../../../widgets/static_grid.dart';
import '../../../../widgets/time_zone_bloc_builder.dart';
import '../../../../widgets/trn_text.dart';
import 'bloc/schedule_meeting_detail_bloc.dart';
import 'bloc/schedule_meeting_detail_state.dart';
import 'meeting_widgets/accept_meeting_request_button.dart';
import 'meeting_widgets/cancel_reject_meeting_button.dart';
import 'meeting_widgets/send_meeting_request_big_button.dart';

class MeetingOrganizer extends StatelessWidget {
  const MeetingOrganizer();

  @override
  Widget build(final BuildContext context) =>
      BlocBuilder<ScheduleMeetingDetailBloc, ScheduleMeetingDetailState>(
        builder: (final _, final state) {
          final user = state.userApi.data!;

          if (user.meeting == null) {
            return const SizedBox();
          }
          return Container(
            margin: const EdgeInsets.only(
              top: 22,
            ),
            decoration: BoxDecoration(
              color: ColorUtils.lighten(
                Theme.of(context).primaryColor,
                0.9,
              ),
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: Theme.of(context).primaryColor,
              ),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 28,
              vertical: 18,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _TextualInformation(),
                const _MeetingMessage(),
                const SizedBox(height: 24),
                StaticGrid(
                  expand: getValueForScreenType(
                    context: context,
                    mobile: true,
                    tablet: false,
                  ),
                  runSpacing: 8,
                  spacing: 8,
                  columns: getValueForScreenType(
                    context: context,
                    mobile: 1,
                    tablet: 2,
                  ),
                  children: [
                    if (SendMeetingRequestBigButton.shouldVisible(context)) ...[
                      const SendMeetingRequestBigButton(),
                    ],
                    if (AcceptMeetingRequestButton.shouldVisible(context)) ...[
                      const AcceptMeetingRequestButton(),
                    ],
                    if (CancelRejectMeetingButton.shouldVisible(context)) ...[
                      const CancelRejectMeetingButton(),
                    ],
                  ],
                ),
              ],
            ),
          );
        },
      );
}

class _TextualInformation extends StatelessWidget {
  const _TextualInformation();

  @override
  Widget build(final BuildContext context) =>
      BlocBuilder<ScheduleMeetingDetailBloc, ScheduleMeetingDetailState>(
        builder: (final _, final state) {
          final user = state.userApi.data!;
          final meeting = user.meeting!;
          return Wrap(
            spacing: 19,
            children: [
              if ([
                MeetingStatus.accepted,
                MeetingStatus.postPending,
                MeetingStatus.postRescheduled,
              ].contains(meeting.status)) ...[
                TimeZoneBlocBuilder(
                  builder: (final timeZone) => Text(
                    '${meeting.acceptedTimeSlot!.startDate.format(
                      format: 'MMMM dd,yyyy  hh:mm a',
                      timeZone: timeZone,
                    )}'
                    ' - '
                    '${meeting.acceptedTimeSlot!.endDate.format(
                      format: 'hh:mm a',
                      timeZone: timeZone,
                    )}',
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
              MeetingChip(meeting),
            ],
          );
        },
      );
}

class _MeetingMessage extends StatelessWidget {
  const _MeetingMessage();

  @override
  Widget build(final BuildContext context) {
    return BlocBuilder<ScheduleMeetingDetailBloc, ScheduleMeetingDetailState>(
      builder: (final _, final state) {
        final profileId = ProfileBloc.of(context).state!.id;
        final meeting = state.userApi.data!.meeting!;
        if (![
          MeetingStatus.pending,
          MeetingStatus.rescheduled,
          MeetingStatus.postPending,
          MeetingStatus.postRejected,
          MeetingStatus.cancelled,
          MeetingStatus.rejected,
          MeetingStatus.postCancelled,
          MeetingStatus.postRejected,
        ].contains(meeting.status)) {
          return const SizedBox();
        }
        final message = meeting.fromUserId == profileId
            ? meeting.toMessage
            : meeting.fromMessage;
        if (message == null) {
          return const SizedBox();
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 6),
            TrnText(
              TranslationKeys.Schedule_Meetings_User_Detail_Note,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Theme.of(context).primaryColor,
              ),
            ),
            Text(
              message,
              style: const TextStyle(
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        );
      },
    );
  }
}
