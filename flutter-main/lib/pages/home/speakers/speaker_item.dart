import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../core/colors.dart';
import '../../../extensions/date_time.dart';
import '../../../flutter_i18n/translation_keys.dart';
import '../../../models/data/session_data.dart';
import '../../../models/data/user_data.dart';
import '../../../models/states/api_state.dart';
import '../../../widgets/avatar.dart';
import '../../../widgets/circular_icon.dart';
import '../../../widgets/image.dart';
import '../../../widgets/ink_well.dart';
import '../../../widgets/time_zone_bloc_builder.dart';
import '../../../widgets/user_container.dart';
import '../../map_location_detail/map_location_detail_dialog.dart';
import '../router/home_route_bloc.dart';
import '../router/home_route_config.dart';
import '../schedule_meetings/router/schedule_meetings_route_config.dart';
import '../sessions/session_detail/session_detail_drawer.dart';
import 'bloc/speakers_bloc.dart';

class SpeakerItem extends StatelessWidget {
  final UserData user;

  const SpeakerItem(this.user);

  @override
  Widget build(final BuildContext context) {
    final item = UserContainer(
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          WCInkWell(
            borderRadius: BorderRadius.circular(5),
            padding: const EdgeInsets.symmetric(
              horizontal: 11,
              vertical: 12,
            ),
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
                  profilePicture: user.profilePicture,
                  size: 58,
                  borderRadius: 10,
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
                        const SizedBox(height: 2),
                        Text(
                          user.jobAtOrganization!,
                          style: TextStyle(
                            fontSize: 12,
                            color: WCColors.black_09.withOpacity(0.5),
                          ),
                        ),
                      ],
                      if (user.bio != null) ...[
                        Text(
                          user.bio!,
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
          ),
          if (user.sessions!.isNotEmpty) ...[
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 11,
                vertical: 12,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(width: 9),
                  Text(
                    translate(context, TranslationKeys.Speakers_Sessions)!,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  for (var i = 0; i < user.sessions!.length; i++) ...[
                    _SessionItem(user.sessions![i]),
                    if (i != user.sessions!.length - 1) ...[
                      const Divider(),
                    ],
                  ],
                ],
              ),
            ),
          ],
        ],
      ),
    );

    return ScreenTypeLayout.builder(
      mobile: (final _) => Padding(
        padding: const EdgeInsets.only(
          top: 11,
          bottom: 11,
        ),
        child: item,
      ),
      tablet: (final _) => Container(
        margin: const EdgeInsets.only(
          bottom: 22,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 27,
          vertical: 23,
        ),
        color: Colors.white,
        child: item,
      ),
    );
  }
}

class _SessionItem extends StatelessWidget {
  final SessionData session;

  const _SessionItem(this.session);

  @override
  Widget build(final BuildContext context) {
    final state = SpeakersBloc.of(context).state;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        WCInkWell(
          padding: const EdgeInsets.symmetric(
            vertical: 18,
            horizontal: 17,
          ),
          onTap: () => SessionDetailDrawer.open(
            context,
            session: session,
            onSessionChanged: SpeakersBloc.of(context).updateSession,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TimeZoneBlocBuilder(
                builder: (final timeZone) => Text(
                  '${session.startDate.format(
                    format: 'EEE, dd MMM, hh:mm a',
                    timeZone: timeZone,
                  )} - ${session.endDate.format(
                    format: 'hh:mm a',
                    timeZone: timeZone,
                  )}',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),
                ),
              ),
              const SizedBox(height: 9),
              Row(
                children: [
                  CircularIcon(
                    session.isInMyAgenda!
                        ? 'ic_star_filled'
                        : 'ic_start_bordered',
                    message: translate(
                      context,
                      session.isInMyAgenda!
                          ? TranslationKeys.Sessions_Remove_From_My_Agenda
                          : TranslationKeys.Sessions_Add_To_My_Agenda,
                    ),
                    size: 24,
                    bgColor: WCColors.yellow_fd,
                    fgColor: WCColors.yellow_ff,
                    isLoading:
                        (state.addToAgendaApi[session.id] ?? ApiState<void>())
                            .isApiInProgress,
                    onTap: () => SpeakersBloc.of(context).addOrRemoveAgenda(
                      session.id,
                      addToAgenda: !session.isInMyAgenda!,
                    ),
                  ),
                  const SizedBox(width: 7),
                  Expanded(
                    child: Text(
                      session.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Text(
                session.description,
                style: TextStyle(
                  color: WCColors.black_09.withOpacity(0.5),
                  fontSize: 13,
                ),
              ),
              if (session.mapLocationId != null ||
                  session.locationName != null) ...[
                const SizedBox(height: 15),
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
            ],
          ),
        ),
      ],
    );
  }
}
