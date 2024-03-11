import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../core/colors.dart';
import '../flutter_i18n/translation_keys.dart';
import '../models/data/session_data.dart';
import '../models/data/session_user_data.dart';
import '../models/states/api_state.dart';
import '../pages/map_location_detail/map_location_detail_dialog.dart';
import 'avatar.dart';
import 'circular_icon.dart';
import 'image.dart';
import 'ink_well.dart';
import 'static_grid.dart';
import 'user_container.dart';

class SessionBasicInfoItem extends StatelessWidget {
  final SessionData session;
  final ApiState<void> addToAgendaState;
  final VoidCallback? onStarTapped;

  const SessionBasicInfoItem({
    required this.session,
    required this.addToAgendaState,
    this.onStarTapped,
  });

  @override
  Widget build(final BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(session.name),
        const SizedBox(height: 5),
        Row(
          children: [
            CircularIcon(
              session.isInMyAgenda! ? 'ic_star_filled' : 'ic_start_bordered',
              message: translate(
                context,
                session.isInMyAgenda!
                    ? TranslationKeys.Sessions_Remove_From_My_Agenda
                    : TranslationKeys.Sessions_Add_To_My_Agenda,
              ),
              size: 24,
              bgColor: WCColors.yellow_fd,
              fgColor: WCColors.yellow_ff,
              isLoading: addToAgendaState.isApiInProgress,
              onTap: onStarTapped,
            ),
            const SizedBox(width: 4),
            Expanded(
              child: Text(
                session.description,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: WCColors.black_09.withOpacity(0.5),
                  fontSize: 13,
                ),
              ),
            ),
          ],
        ),
        if (session.mapLocationId != null || session.locationName != null) ...[
          const SizedBox(height: 5),
          Transform.translate(
            offset: const Offset(-8, 0),
            child: WCInkWell(
              padding: const EdgeInsets.all(8),
              onTap: session.mapLocationId == null
                  ? null
                  : () => MapLocationDetailDialog.show(
                        context,
                        mapLocationId: session.mapLocation!.id,
                      ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  WCImage(
                    image: 'ic_pin.png',
                    width: 20,
                    color: WCColors.black_09.withOpacity(0.5),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    session.mapLocation?.name ?? session.locationName!,
                    style: TextStyle(
                      decoration: session.mapLocationId == null
                          ? null
                          : TextDecoration.underline,
                      color: WCColors.black_09.withOpacity(0.5),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
        const SizedBox(height: 30),
        _SessionUsers(session),
      ],
    );
  }
}

class _SessionUsers extends StatelessWidget {
  final SessionData session;

  const _SessionUsers(this.session);

  @override
  Widget build(final BuildContext context) {
    final List<SessionUserData> uniqueUserRoles = [];
    for (final ur in session.userRoles!) {
      if (uniqueUserRoles.indexWhere((final uur) => uur.userId == ur.userId) ==
          -1) {
        uniqueUserRoles.add(ur);
      }
    }
    return StaticGrid(
      spacing: 22,
      runSpacing: 26,
      columns: getValueForScreenType(
        context: context,
        mobile: 1,
        tablet: 2,
        desktop: 3,
      ),
      children: uniqueUserRoles
          .map(
            (final ur) => _SessionUser(ur),
          )
          .toList(),
    );
  }
}

class _SessionUser extends StatelessWidget {
  final SessionUserData sessionUser;

  const _SessionUser(this.sessionUser);

  @override
  Widget build(final BuildContext context) {
    final user = sessionUser.user!;
    final role = sessionUser.role!;
    return UserContainer(
      child: Row(
        children: [
          UserAvatar(
            size: 58,
            profilePicture: user.profilePicture,
          ),
          const SizedBox(width: 9),
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
                const SizedBox(height: 3),
                if (user.jobAtOrganization != null) ...[
                  Text(
                    user.jobAtOrganization!,
                    style: TextStyle(
                      fontSize: 12,
                      color: WCColors.black_09.withOpacity(0.5),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
                Text(
                  role.name,
                  style: TextStyle(
                    fontSize: 12,
                    color: WCColors.black_09.withOpacity(0.5),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
