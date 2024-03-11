import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/event_bloc.dart';
import '../../bloc/home_drawer_bloc.dart';
import '../../bloc/profile_bloc.dart';
import '../../bloc/state/event_state.dart';
import '../../bloc/state/home_drawer_state.dart';
import '../../flutter_i18n/translation_keys.dart';
import '../../models/data/event_data.dart';
import '../../models/data/user_data.dart';
import '../../router/app_route_bloc.dart';
import '../../router/app_route_state.dart';
import '../../utils/color_utils.dart';
import '../../widgets/avatar.dart';
import '../../widgets/counter.dart';
import '../../widgets/image.dart';
import '../../widgets/ink_well.dart';
import 'router/home_route_bloc.dart';
import 'router/home_route_config.dart';

class DrawerContainer extends StatelessWidget {
  static const DRAWER_WIDTH = 241.0;

  const DrawerContainer();

  @override
  Widget build(final BuildContext context) {
    return BlocSelector<EventBloc, EventState, Color>(
      selector: (final state) =>
          state.getEventApi.data!.appConfig.navigationDrawerColor,
      builder: (final _, final navColor) => Container(
        width: DRAWER_WIDTH,
        color: navColor,
        child: const SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 31),
              _Logo(),
              SizedBox(height: 27),
              _ProfileInfo(),
              SizedBox(height: 18),
              Expanded(
                child: _DrawerItemsList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  const _Logo();

  @override
  Widget build(final BuildContext context) {
    return BlocSelector<EventBloc, EventState, EventData>(
      selector: (final state) => state.getEventApi.data!,
      builder: (final _, final event) => Row(
        children: [
          const SizedBox(width: 28),
          if (event.appConfig.eventLogo != null) ...[
            WCImage(
              image: event.appConfig.eventLogo!,
              width: 30,
            ),
            const SizedBox(width: 13),
          ],
          Expanded(
            child: Text(
              event.name,
              style: const TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileInfo extends StatelessWidget {
  const _ProfileInfo();

  @override
  Widget build(final BuildContext context) {
    return BlocBuilder<ProfileBloc, UserData?>(
      builder: (final _, final profile) =>
          BlocSelector<EventBloc, EventState, Color>(
        selector: (final state) =>
            state.getEventApi.data!.appConfig.navigationDrawerColor,
        builder: (final _, final navColor) => Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Stack(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 9),
                decoration: BoxDecoration(
                  color: ColorUtils.darken(
                    navColor,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 11),
                    UserAvatar(
                      profilePicture: profile?.profilePicture,
                      borderRadius: 10,
                      size: 56,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            profile?.fullName ?? '',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          if (profile?.jobAtOrganization != null) ...[
                            const SizedBox(height: 11),
                            Text(
                              profile!.jobAtOrganization!,
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.5),
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned.fill(
                child: WCInkWell(
                  isDark: true,
                  borderRadius: BorderRadius.circular(10),
                  onTap: () {
                    if (Scaffold.hasDrawer(context)) {
                      Navigator.pop(context);
                    }
                    HomeRouteBloc.of(context).updateRouteConfig(
                      const HomeRouteConfig.profile(),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DrawerItemsList extends StatelessWidget {
  const _DrawerItemsList();

  @override
  Widget build(final BuildContext context) {
    return BlocBuilder<HomeDrawerBloc, HomeDrawerState>(
      builder: (final _, final state) => BlocBuilder<ProfileBloc, UserData?>(
        builder: (final _, final profile) => ListView(
          controller: ScrollController(),
          children: [
            const _DrawerItem(
              titleKey: TranslationKeys.Home_Drawer_Dashboard,
              image: 'ic_dashboard',
              config: HomeRouteConfig.dashboard(),
            ),
            const _DrawerItem(
              titleKey: TranslationKeys.Home_Drawer_Schedule_Meetings,
              image: 'ic_schedule_meeting',
              config: HomeRouteConfig.scheduleMeetings(),
            ),
            const _DrawerItem(
              titleKey: TranslationKeys.Home_Drawer_Meeting_Management,
              image: 'ic_meeting_management',
              config: HomeRouteConfig.meetingManagement(),
            ),
            const _DrawerItem(
              titleKey: TranslationKeys.Home_Drawer_Sessions,
              image: 'ic_sessions',
              config: HomeRouteConfig.sessions(),
            ),
            const _DrawerItem(
              titleKey: TranslationKeys.Home_Drawer_My_Agenda,
              image: 'ic_my_agenda',
              config: HomeRouteConfig.myAgenda(),
            ),
            const _DrawerItem(
              titleKey: TranslationKeys.Home_Drawer_Speakers,
              image: 'ic_speakers',
              config: HomeRouteConfig.speakers(),
            ),
            const _DrawerItem(
              titleKey: TranslationKeys.Home_Drawer_Exhibitors,
              image: 'ic_exhibitors',
              config: HomeRouteConfig.exhibitors(),
            ),
            const _DrawerItem(
              titleKey: TranslationKeys.Home_Drawer_Sponsors,
              image: 'ic_sponsors',
              config: HomeRouteConfig.sponsors(),
            ),
            _DrawerItem(
              titleKey: TranslationKeys.Home_Drawer_Messages,
              image: 'ic_messages',
              counter: state.unreadMessageCountApi.data,
              config: const HomeRouteConfig.messages(),
            ),
            const _DrawerItem(
              titleKey: TranslationKeys.Home_Drawer_Lead_Scanner,
              image: 'ic_lead_scanner',
              config: HomeRouteConfig.leadScanner(),
            ),
            const _DrawerItem(
              titleKey: TranslationKeys.Home_Drawer_Feeds,
              image: 'ic_feeds',
              config: HomeRouteConfig.feeds(),
            ),
            if (profile?.organization != null &&
                profile?.permissions?.canEditOrganization == true) ...[
              const _DrawerItem(
                titleKey: TranslationKeys.Home_Drawer_Organization,
                image: 'ic_organization',
                config: HomeRouteConfig.organization(),
              ),
            ],
            _DrawerItem(
              titleKey: TranslationKeys.Home_Drawer_Logout,
              image: 'ic_logout',
              onTap: () => ProfileBloc.of(context).logout(),
            ),
          ],
        ),
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final String titleKey;
  final String image;
  final HomeRouteConfig? config;
  final VoidCallback? onTap;
  final int? counter;

  const _DrawerItem({
    required this.titleKey,
    required this.image,
    this.config,
    this.onTap,
    this.counter,
  });

  @override
  Widget build(final BuildContext context) {
    return BlocSelector<AppRouteBloc, AppRouteState, HomeRouteConfig?>(
      selector: (final state) => state.routeConfig.when(
        auth: (final _) => null,
        home: (final home) => home,
      ),
      builder: (final _, final selectedConfig) {
        final isSelected = selectedConfig.runtimeType == config.runtimeType;
        return Container(
          color:
              isSelected ? Theme.of(context).primaryColor : Colors.transparent,
          child: WCInkWell(
            isDark: true,
            hoverColor: isSelected
                ? ColorUtils.darken(Theme.of(context).primaryColor)
                : Colors.white.withOpacity(0.2),
            onTap: onTap ??
                () {
                  if (config != null) {
                    HomeRouteBloc.of(context).updateRouteConfig(config!);
                    if (Scaffold.of(context).hasDrawer) {
                      Navigator.pop(context);
                    }
                  }
                },
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Row(
              children: [
                const SizedBox(width: 29),
                WCImage(
                  image: '$image.png',
                  width: 20,
                  color: Colors.white.withOpacity(isSelected ? 1 : 0.4),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Text(
                    translate(context, titleKey)!,
                    style: TextStyle(
                      color: Colors.white.withOpacity(isSelected ? 1 : 0.4),
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ),
                if (counter != null && counter! > 0) ...[
                  Counter(
                    count: counter!,
                  ),
                  const SizedBox(width: 10),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
