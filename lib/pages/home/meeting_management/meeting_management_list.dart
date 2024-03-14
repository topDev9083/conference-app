import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../bloc/profile_bloc.dart';
import '../../../core/colors.dart';
import '../../../flutter_i18n/translation_keys.dart';
import '../../../models/data/meeting_data.dart';
import '../../../models/data/user_data.dart';
import '../../../models/enums/meeting_status.dart';
import '../../../widgets/avatar.dart';
import '../../../widgets/connection_information.dart';
import '../../../widgets/meeting_chip.dart';
import '../../../widgets/outlined_button.dart';
import '../../../widgets/user_container.dart';
import '../messages/router/messages_route_config.dart';
import '../router/home_route_bloc.dart';
import '../router/home_route_config.dart';
import '../schedule_meetings/router/schedule_meetings_route_config.dart';
import 'bloc/meeting_management_bloc.dart';
import 'bloc/meeting_management_state.dart';
import 'meeting_management_empty.dart';

class MeetingManagementList extends StatelessWidget {
  const MeetingManagementList();

  @override
  Widget build(final BuildContext context) {
    return BlocBuilder<MeetingManagementBloc, MeetingManagementState>(
      builder: (final _, final state) => state.getMeetingsApi.data == null
          ? Center(
              child: ConnectionInformation(
                error: state.getMeetingsApi.error,
                onRetry: MeetingManagementBloc.of(context).getMyMeetings,
              ),
            )
          : state.filteredMeetings!.isEmpty
              ? const Center(
                  child: MeetingManagementEmpty(),
                )
              : ListView.builder(
                  itemBuilder: (final _, final index) => _MeetingManagementItem(
                    state.filteredMeetings![index],
                    isForStatusAccepted:
                        state.selectedMeetingStatus == MeetingStatus.accepted,
                  ),
                  itemCount: state.filteredMeetings!.length,
                  padding: EdgeInsets.symmetric(
                    horizontal: getValueForScreenType(
                      context: context,
                      mobile: 16,
                      tablet: 30,
                    ),
                    vertical: 25,
                  ),
                ),
    );
  }
}

class _MeetingManagementItem extends StatelessWidget {
  final MeetingData meeting;
  final bool isForStatusAccepted;

  const _MeetingManagementItem(
    this.meeting, {
    required this.isForStatusAccepted,
  });

  @override
  Widget build(final BuildContext context) {
    final user = ProfileBloc.of(context).state!.id == meeting.fromUserId
        ? meeting.toUser!
        : meeting.fromUser!;
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: UserContainer(
        showShadow: true,
        onTap: () => HomeRouteBloc.of(context).updateRouteConfig(
          HomeRouteConfig.scheduleMeetings(
            scheduleMeetingsRouteConfig: ScheduleMeetingsRouteConfig(
              selectedUserId: user.id,
            ),
          ),
        ),
        child: Row(
          children: [
            UserAvatar(
              size: 67,
              profilePicture: user.profilePicture,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.fullName,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  if (user.jobAtOrganization != null) ...[
                    const SizedBox(height: 3),
                    Text(
                      user.jobAtOrganization!,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                        color: WCColors.black_09.withOpacity(0.5),
                      ),
                    ),
                  ],
                  const SizedBox(height: 3),
                  MeetingChip(
                    meeting,
                    isForStatusAccepted: isForStatusAccepted,
                  ),
                ],
              ),
            ),
            WCOutlinedButton(
              title: translate(
                context,
                TranslationKeys.Schedule_Meetings_User_Detail_Message,
              ),
              onTap: () => _onSendMessage(context, user),
              type: getValueForScreenType(
                context: context,
                mobile: WCOutlinedButtonType.normal,
                desktop: WCOutlinedButtonType.bigA,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onSendMessage(final BuildContext context, final UserData user) {
    HomeRouteBloc.of(context).updateRouteConfig(
      HomeRouteConfig.messages(
        messagesRouteConfig: MessagesRouteConfig(
          selectedUserId: user.id,
        ),
      ),
    );
  }
}
