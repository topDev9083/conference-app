import 'package:flutter/material.dart';

import '../bloc/profile_bloc.dart';
import '../core/colors.dart';
import '../flutter_i18n/translation_keys.dart';
import '../models/data/meeting_data.dart';
import '../others/meeting_status_events.dart';

class MeetingChip extends StatelessWidget {
  final MeetingData? meeting;
  final bool isForStatusAccepted;

  const MeetingChip(
    this.meeting, {
    this.isForStatusAccepted = false,
  });

  @override
  Widget build(final BuildContext context) {
    final profileId = ProfileBloc.of(context).state!.id;
    Color? bg;
    String? titleKey;
    if (meeting == null) {
      return const SizedBox();
    }
    meeting!.callMeetingStatusEvent(
      profileId,
      MeetingStatusEvents(
        pendingMe: () {
          bg = Theme.of(context).primaryColor;
          titleKey = TranslationKeys.Meeting_Statuses_Request_Sent;
        },
        pendingHim: () {
          bg = Theme.of(context).primaryColor;
          titleKey = TranslationKeys.Meeting_Statuses_Request_Received;
        },
        rescheduledMe: () {
          bg = Theme.of(context).primaryColor;
          titleKey = TranslationKeys.Meeting_Statuses_Reschedule_Received;
        },
        rescheduledHim: () {
          bg = Theme.of(context).primaryColor;
          titleKey = TranslationKeys.Meeting_Statuses_Reschedule_Sent;
        },
        acceptedMe: () {
          bg = WCColors.green_29;
          titleKey = TranslationKeys.Meeting_Statuses_Accepted;
        },
        acceptedHim: () {
          bg = WCColors.green_29;
          titleKey = TranslationKeys.Meeting_Statuses_Accepted;
        },
        postPendingMe: () {
          if (isForStatusAccepted) {
            bg = WCColors.green_29;
            titleKey = TranslationKeys.Meeting_Statuses_Accepted;
          } else {
            bg = Theme.of(context).primaryColor;
            titleKey = TranslationKeys.Meeting_Statuses_Reschedule_Sent;
          }
        },
        postPendingHim: () {
          if (isForStatusAccepted) {
            bg = WCColors.green_29;
            titleKey = TranslationKeys.Meeting_Statuses_Accepted;
          } else {
            bg = Theme.of(context).primaryColor;
            titleKey = TranslationKeys.Meeting_Statuses_Reschedule_Received;
          }
        },
        postRescheduledMe: () {
          if (isForStatusAccepted) {
            bg = WCColors.green_29;
            titleKey = TranslationKeys.Meeting_Statuses_Accepted;
          } else {
            bg = Theme.of(context).primaryColor;
            titleKey = TranslationKeys.Meeting_Statuses_Reschedule_Received;
          }
        },
        postRescheduledHim: () {
          if (isForStatusAccepted) {
            bg = WCColors.green_29;
            titleKey = TranslationKeys.Meeting_Statuses_Accepted;
          } else {
            bg = Theme.of(context).primaryColor;
            titleKey = TranslationKeys.Meeting_Statuses_Reschedule_Sent;
          }
        },
        cancelledMe: () {
          bg = Colors.grey;
          titleKey = TranslationKeys.Meeting_Statuses_Cancelled;
        },
        cancelledHim: () {
          bg = Colors.grey;
          titleKey = TranslationKeys.Meeting_Statuses_Cancelled;
        },
        rejectedMe: () {
          bg = Colors.redAccent;
          titleKey = TranslationKeys.Meeting_Statuses_Rejected;
        },
        rejectedHim: () {
          bg = Colors.redAccent;
          titleKey = TranslationKeys.Meeting_Statuses_Rejected;
        },
        postCancelledMe: () {
          bg = Colors.grey;
          titleKey = TranslationKeys.Meeting_Statuses_Cancelled;
        },
        postCancelledHim: () {
          bg = Colors.grey;
          titleKey = TranslationKeys.Meeting_Statuses_Cancelled;
        },
        postRejectedMe: () {
          bg = Colors.grey;
          titleKey = TranslationKeys.Meeting_Statuses_Cancelled;
        },
        postRejectedHim: () {
          bg = Colors.grey;
          titleKey = TranslationKeys.Meeting_Statuses_Cancelled;
        },
      ),
    );
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 3,
      ),
      decoration: BoxDecoration(
        color: bg ?? Colors.black,
        borderRadius: BorderRadius.circular(3),
      ),
      child: Text(
        translate(context, titleKey) ?? '',
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
        ),
      ),
    );
  }
}
