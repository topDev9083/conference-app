import 'package:flutter/material.dart';

import '../core/colors.dart';
import '../flutter_i18n/translation_keys.dart';
import '../models/data/user_data.dart';
import '../pages/home/messages/router/messages_route_config.dart';
import '../pages/home/router/home_route_bloc.dart';
import '../pages/home/router/home_route_config.dart';
import '../pages/home/schedule_meetings/router/schedule_meetings_route_config.dart';
import '../utils/color_utils.dart';
import 'avatar.dart';
import 'outlined_button.dart';

class ColleagueItem extends StatelessWidget {
  final UserData user;
  final bool isFromDrawer;

  const ColleagueItem(
    this.user, {
    this.isFromDrawer = false,
  });

  @override
  Widget build(final BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 11,
        vertical: 11,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: WCColors.grey_e7,
        ),
        boxShadow: [
          BoxShadow(
            offset: const Offset(4.6, 32.7),
            blurRadius: 84,
            color: Colors.black.withOpacity(0.03),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              UserAvatar(
                profilePicture: user.profilePicture,
                size: 52,
              ),
              const SizedBox(width: 9),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.fullName,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (user.jobTitle != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        user.jobTitle!,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: WCColors.black_09.withOpacity(0.5),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: WCOutlinedButton(
              title: translate(
                context,
                TranslationKeys.Schedule_Meetings_User_Detail_Message,
              ),
              backgroundColor: ColorUtils.lighten(
                Theme.of(context).primaryColor,
                0.9,
              ),
              borderColor: Theme.of(context).primaryColor,
              onTap: () {
                if (isFromDrawer) {
                  Navigator.pop(context);
                }
                HomeRouteBloc.of(context).updateRouteConfig(
                  HomeRouteConfig.messages(
                    messagesRouteConfig: MessagesRouteConfig(
                      selectedUserId: user.id,
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: WCOutlinedButton(
              title: translate(
                context,
                TranslationKeys.Schedule_Meetings_User_Detail_Schedule_Meeting,
              ),
              borderColor: WCColors.grey_9f.withOpacity(0.93),
              onTap: () {
                if (isFromDrawer) {
                  Navigator.pop(context);
                }
                HomeRouteBloc.of(context).updateRouteConfig(
                  HomeRouteConfig.scheduleMeetings(
                    scheduleMeetingsRouteConfig: ScheduleMeetingsRouteConfig(
                      selectedUserId: user.id,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
