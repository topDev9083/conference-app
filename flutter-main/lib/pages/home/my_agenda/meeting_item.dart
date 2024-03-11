import 'package:flutter/material.dart';

import '../../../bloc/profile_bloc.dart';
import '../../../core/colors.dart';
import '../../../flutter_i18n/translation_keys.dart';
import '../../../models/data/meeting_data.dart';
import '../../../models/data/user_data.dart';
import '../../../widgets/avatar.dart';
import '../../../widgets/image.dart';
import '../../../widgets/ink_well.dart';
import '../../map_location_detail/map_location_detail_dialog.dart';
import '../router/home_route_bloc.dart';
import '../router/home_route_config.dart';
import '../schedule_meetings/router/schedule_meetings_route_config.dart';
import 'time.dart';

class MeetingItem extends StatelessWidget {
  final MeetingData meeting;

  const MeetingItem(this.meeting);

  @override
  Widget build(final BuildContext context) {
    final user = getUser(context);
    return WCInkWell(
      padding: const EdgeInsets.symmetric(vertical: 25),
      hoverColor: Theme.of(context).primaryColor.withOpacity(0.05),
      onTap: () => HomeRouteBloc.of(context).updateRouteConfig(
        HomeRouteConfig.scheduleMeetings(
          scheduleMeetingsRouteConfig: ScheduleMeetingsRouteConfig(
            selectedUserId: user.id,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Transform.translate(
            offset: const Offset(0, 1.5),
            child: Time(
              start: meeting.acceptedTimeSlot!.startDate,
              end: meeting.acceptedTimeSlot!.endDate,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  translate(context, TranslationKeys.My_Agenda_Meeting)!,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 11),
                _getMeetingAvatar(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  UserData getUser(final BuildContext context) {
    return ProfileBloc.of(context).state!.id == meeting.fromUserId
        ? meeting.toUser!
        : meeting.fromUser!;
  }

  Widget _getMeetingAvatar(final BuildContext context) {
    final user = getUser(context);
    return Row(
      children: [
        UserAvatar(
          borderRadius: 999,
          profilePicture: user.profilePicture,
          size: 50,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user.fullName,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (user.jobAtOrganization != null) ...[
                Text(
                  user.jobAtOrganization!,
                  style: TextStyle(
                    fontSize: 13,
                    color: WCColors.black_09.withOpacity(0.5),
                  ),
                ),
              ],
              Transform.translate(
                offset: const Offset(-4, 0),
                child: WCInkWell(
                  padding: const EdgeInsets.all(4),
                  onTap: meeting.table?.mapLocationId == null
                      ? null
                      : () => MapLocationDetailDialog.show(
                            context,
                            mapLocationId: meeting.table!.mapLocationId!,
                          ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      WCImage(
                        image: 'ic_pin.png',
                        height: 15,
                        color: WCColors.black_09.withOpacity(0.5),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        meeting.table!.name,
                        style: TextStyle(
                          decoration: meeting.table?.mapLocationId == null
                              ? null
                              : TextDecoration.underline,
                          fontSize: 12,
                          color: WCColors.black_09.withOpacity(0.5),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
