import 'dart:math' as math;

import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';

import '../../../core/colors.dart';
import '../../../models/data/session_data.dart';
import '../../../models/data/session_user_data.dart';
import '../../../utils/color_utils.dart';
import '../../../widgets/avatar.dart';
import '../../../widgets/chips.dart';
import '../../../widgets/image.dart';
import '../../../widgets/ink_well.dart';
import '../../map_location_detail/map_location_detail_dialog.dart';
import '../sessions/session_detail/session_detail_drawer.dart';
import 'bloc/dashboard_bloc.dart';

class SessionItem extends StatelessWidget {
  final SessionData session;

  const SessionItem(this.session);

  @override
  Widget build(final BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: WCInkWell(
        hoverColor: Theme.of(context).primaryColor.withOpacity(0.05),
        borderRadius: BorderRadius.circular(5),
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 19,
        ),
        onTap: () => SessionDetailDrawer.open(
          context,
          session: session,
          onSessionChanged: DashboardBloc.of(context).updateSession,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    session.name,
                    style: TextStyle(
                      color: WCColors.black_09.withOpacity(0.93),
                    ),
                  ),
                ),
                WCImage(
                  image: session.isInMyAgenda!
                      ? 'ic_bookmark_filled.png'
                      : 'ic_bookmark_bordered.png',
                  width: 17,
                  color: WCColors.black_09.withOpacity(0.93),
                ),
              ],
            ),
            const SizedBox(height: 13),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: DateTimeChip(
                      startDate: session.startDate,
                      endDate: session.endDate,
                    ),
                  ),
                ),
                if (session.mapLocationId != null)
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: ColorUtils.lighten(
                        Theme.of(context).primaryColor,
                        0.9,
                      ),
                    ),
                    child: WCInkWell(
                      padding: const EdgeInsets.all(8),
                      borderRadius: BorderRadius.circular(7),
                      onTap: () => MapLocationDetailDialog.show(
                        context,
                        mapLocationId: session.mapLocationId!,
                      ),
                      child: WCImage(
                        image: 'ic_pin.png',
                        width: 15,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 17),
            _SessionUsers(session.userRoles!),
          ],
        ),
      ),
    );
  }
}

class _SessionUsers extends StatelessWidget {
  final BuiltList<SessionUserData> sessionUsers;

  const _SessionUsers(this.sessionUsers);

  @override
  Widget build(final BuildContext context) {
    if (sessionUsers.isEmpty) {
      return const SizedBox(height: 29);
    }
    return Row(
      children: [
        ...sessionUsers
            .sublist(0, math.min(4, sessionUsers.length))
            .map(
              (final su) => Padding(
                padding: const EdgeInsetsDirectional.only(
                  end: 5,
                ),
                child: UserAvatar(
                  profilePicture: su.user!.profilePicture,
                  size: 29,
                ),
              ),
            )
            .toList(),
        if (sessionUsers.length > 4)
          Container(
            width: 29,
            height: 29,
            decoration: BoxDecoration(
              color: ColorUtils.lighten(
                Theme.of(context).primaryColor,
                0.9,
              ),
              borderRadius: BorderRadius.circular(7),
            ),
            alignment: Alignment.center,
            child: Text(
              '+${sessionUsers.length - 4}',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
      ],
    );
  }
}
