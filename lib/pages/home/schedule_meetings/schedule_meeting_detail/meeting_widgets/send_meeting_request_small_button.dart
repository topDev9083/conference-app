import 'package:flutter/material.dart';

import '../../../../../bloc/home_drawer_bloc.dart';
import '../../../../../flutter_i18n/translation_keys.dart';
import '../../../../../widgets/outlined_button.dart';
import '../bloc/schedule_meeting_detail_bloc.dart';
import '../time_slots.dart';

class SendMeetingRequestSmallButton extends StatelessWidget {
  const SendMeetingRequestSmallButton();

  @override
  Widget build(final BuildContext context) {
    return WCOutlinedButton(
      title: translate(
        context,
        TranslationKeys.Schedule_Meetings_User_Detail_Schedule_Meeting,
      ),
      iconPng: 'ic_schedule_meeting.png',
      onTap: () => openTimeSlots(context),
    );
  }

  static bool shouldVisible(final BuildContext context) {
    final meeting =
        ScheduleMeetingDetailBloc.of(context).state.userApi.data!.meeting;
    return meeting == null;
  }

  static void openTimeSlots(final BuildContext context) {
    HomeDrawerBloc.of(context).updateEndDrawerWidget(
      TimeSlots(
        bloc: ScheduleMeetingDetailBloc.of(context),
      ),
    );
    Scaffold.of(context).openEndDrawer();
  }
}
