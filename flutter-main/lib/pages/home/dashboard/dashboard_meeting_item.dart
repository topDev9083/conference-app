import 'package:flutter/material.dart';

import '../../../bloc/profile_bloc.dart';
import '../../../core/colors.dart';
import '../../../flutter_i18n/translation_keys.dart';
import '../../../models/data/meeting_data.dart';
import '../../../widgets/avatar.dart';
import '../../../widgets/chips.dart';
import '../../../widgets/ink_well.dart';
import '../router/home_route_bloc.dart';
import '../router/home_route_config.dart';
import '../schedule_meetings/router/schedule_meetings_route_config.dart';

class DashboardMeetingItem extends StatelessWidget {
  final MeetingData meeting;

  const DashboardMeetingItem(this.meeting);

  @override
  Widget build(final BuildContext context) {
    final profile = ProfileBloc.of(context).state;
    final user =
        meeting.toUserId == profile!.id ? meeting.fromUser! : meeting.toUser!;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: WCInkWell(
        padding: const EdgeInsets.all(14),
        borderRadius: BorderRadius.circular(5),
        hoverColor: Theme.of(context).primaryColor.withOpacity(0.05),
        onTap: () => HomeRouteBloc.of(context).updateRouteConfig(
          HomeRouteConfig.scheduleMeetings(
            scheduleMeetingsRouteConfig: ScheduleMeetingsRouteConfig(
              selectedUserId: user.id,
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                UserAvatar(
                  profilePicture: user.profilePicture,
                  size: 56,
                ),
                const SizedBox(width: 13),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.fullName,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                      if (user.jobAtOrganization != null) ...[
                        const SizedBox(height: 7),
                        Text(
                          user.jobAtOrganization!,
                          style: TextStyle(
                            fontSize: 12,
                            color: WCColors.black_09.withOpacity(0.5),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ...meeting.isAccepted() &&
                    meeting.timeSlotStartDate != null &&
                    meeting.timeSlotEndDate != null
                ? [
                    DateTimeChip(
                      startDate: meeting.timeSlotStartDate!,
                      endDate: meeting.timeSlotEndDate!,
                    ),
                  ]
                : [
                    BaseChip(
                      translate(
                        context,
                        TranslationKeys.Meeting_Statuses_Request_Received,
                      )!,
                    ),
                  ],
          ],
        ),
      ),
    );
  }
}
