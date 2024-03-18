import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../../core/colors.dart';
import '../../../../extensions/date_time.dart';
import '../../../../flutter_i18n/translation_keys.dart';
import '../../../../models/data/role_data.dart';
import '../../../../models/data/track_data.dart';
import '../../../../models/data/user_data.dart';
import '../../../../utils/color_utils.dart';
import '../../../../widgets/avatar.dart';
import '../../../../widgets/circular_icon.dart';
import '../../../../widgets/ink_well.dart';
import '../../../../widgets/time_zone_bloc_builder.dart';
import '../../router/home_route_bloc.dart';
import '../../router/home_route_config.dart';
import '../../schedule_meetings/router/schedule_meetings_route_config.dart';
import 'bloc/session_detail_bloc.dart';
import 'bloc/session_detail_state.dart';

class SessionDetailList extends StatelessWidget {
  const SessionDetailList();

  @override
  Widget build(final BuildContext context) {
    return BlocBuilder<SessionDetailBloc, SessionDetailState>(
      builder: (final _, final state) => ListView(
        padding: EdgeInsets.symmetric(
          horizontal: getValueForScreenType(
            context: context,
            mobile: 16,
            tablet: 25,
          ),
          vertical: 11,
        ),
        children: [
          TimeZoneBlocBuilder(
            builder: (final timeZone) => Text(
              '${state.session.startDate.format(
                format: 'EEE, dd MMM hh:mm a',
                timeZone: timeZone,
              )} - ${state.session.endDate.format(
                format: 'hh:mm a',
                timeZone: timeZone,
              )}',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 9),
          Row(
            children: [
              CircularIcon(
                state.session.isInMyAgenda!
                    ? 'ic_star_filled'
                    : 'ic_start_bordered',
                message: translate(
                  context,
                  state.session.isInMyAgenda!
                      ? TranslationKeys.Sessions_Remove_From_My_Agenda
                      : TranslationKeys.Sessions_Add_To_My_Agenda,
                ),
                size: 24,
                bgColor: WCColors.yellow_fd,
                fgColor: WCColors.yellow_ff,
                isLoading: state.addToAgendaApi.isApiInProgress,
                onTap: SessionDetailBloc.of(context).addOrRemoveAgenda,
              ),
              const SizedBox(width: 7),
              Expanded(
                child: Text(
                  state.session.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            state.session.description,
            style: const TextStyle(
              fontSize: 13,
            ),
          ),
          if (state.session.tracks!.isNotEmpty) ...[
            const SizedBox(height: 14),
            Wrap(
              spacing: 9,
              runSpacing: 9,
              children: state.session
                  .getTracksIncludingNestedTracks()
                  .map((final track) => _TrackItem(track))
                  .toList(),
            ),
          ],
          const SizedBox(height: 21),
          ...state.session.roles!.map((final role) => _RoleUsers(role)),
        ],
      ),
    );
  }
}

class _TrackItem extends StatelessWidget {
  final TrackData track;

  const _TrackItem(this.track);

  @override
  Widget build(final BuildContext context) {
    final bgColor = track.colorHex == null
        ? Colors.white
        : ColorUtils.fromHex(track.colorHex!);
    final fgColor = track.colorHex == null
        ? WCColors.black_09
        : ThemeData.estimateBrightnessForColor(bgColor) == Brightness.dark
            ? Colors.white
            : WCColors.black_09;

    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 6,
        horizontal: 11,
      ),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        track.name,
        style: TextStyle(
          color: fgColor,
          fontWeight: FontWeight.w500,
          fontSize: 13,
        ),
      ),
    );
  }
}

class _RoleUsers extends StatelessWidget {
  final RoleData role;

  const _RoleUsers(this.role);

  @override
  Widget build(final BuildContext context) {
    if (role.users!.isEmpty) {
      return const SizedBox();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 31),
        Text(
          role.name,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 15),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Column(
            children: [
              for (var i = 0; i < role.users!.length; i++) ...[
                _RoleUser(role.users![i]),
                if (i != role.users!.length - 1) ...[
                  const Divider(),
                ],
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _RoleUser extends StatelessWidget {
  final UserData user;

  const _RoleUser(this.user);

  @override
  Widget build(final BuildContext context) {
    return WCInkWell(
      onTap: () {
        HomeRouteBloc.of(context).updateRouteConfig(
          HomeRouteConfig.scheduleMeetings(
            scheduleMeetingsRouteConfig: ScheduleMeetingsRouteConfig(
              selectedUserId: user.id,
            ),
          ),
        );
        Navigator.pop(context);
      },
      padding: const EdgeInsetsDirectional.only(
        top: 9,
        bottom: 18,
        start: 15,
        end: 15,
      ),
      child: Row(
        children: [
          UserAvatar(
            profilePicture: user.profilePicture,
            size: 56,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.fullName,
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                ),
                if (user.jobAtOrganization != null) ...[
                  const SizedBox(height: 4),
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
    );
  }
}
