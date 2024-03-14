import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../flutter_i18n/translation_keys.dart';
import '../../../models/enums/meeting_status.dart';
import '../../../widgets/elevated_button.dart';
import '../../../widgets/image.dart';
import '../../../widgets/trn_text.dart';
import '../router/home_route_bloc.dart';
import '../router/home_route_config.dart';
import '../schedule_meetings/router/schedule_meetings_route_config.dart';
import 'bloc/meeting_management_bloc.dart';
import 'bloc/meeting_management_state.dart';

class MeetingManagementEmpty extends StatelessWidget {
  const MeetingManagementEmpty();

  @override
  Widget build(final BuildContext context) {
    return BlocBuilder<MeetingManagementBloc, MeetingManagementState>(
      builder: (final _, final state) {
        String titleKey;
        String subtitleKey;
        switch (state.selectedMeetingStatus) {
          case MeetingStatus.pending:
            titleKey =
                TranslationKeys.Meeting_Management_Error_Pending_Empty_Title;
            subtitleKey =
                TranslationKeys.Meeting_Management_Error_Pending_Empty_Subtitle;
            break;
          case MeetingStatus.accepted:
            titleKey =
                TranslationKeys.Meeting_Management_Error_Accepted_Empty_Title;
            subtitleKey = TranslationKeys
                .Meeting_Management_Error_Accepted_Empty_Subtitle;
            break;
          case MeetingStatus.cancelled:
            titleKey =
                TranslationKeys.Meeting_Management_Error_Cancelled_Empty_Title;
            subtitleKey = TranslationKeys
                .Meeting_Management_Error_Cancelled_Empty_Subtitle;
            break;
          default:
            titleKey = '';
            subtitleKey = '';
            break;
        }
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const WCImage(
              image: 'il_meeting_pending.png',
              width: 245,
            ),
            const SizedBox(height: 30),
            TrnText(
              titleKey,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 12),
            TrnText(
              subtitleKey,
            ),
            const SizedBox(height: 20),
            WCElevatedButton(
              translate(
                context,
                TranslationKeys.Home_Drawer_Schedule_Meetings,
              )!,
              onTap: () => HomeRouteBloc.of(context).updateRouteConfig(
                const HomeRouteConfig.scheduleMeetings(
                  scheduleMeetingsRouteConfig: ScheduleMeetingsRouteConfig(),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
