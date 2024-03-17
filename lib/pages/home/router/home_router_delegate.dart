import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../router/app_route_bloc.dart';
import '../../../router/app_route_state.dart';
import '../../empty/empty_screen.dart';
import '../dashboard/dashboard_screen.dart';
import '../edit_organization/edit_organization_screen.dart';
import '../exhibitors/exhibitors_screen.dart';
import '../feeds/feeds_screen.dart';
import '../lead_scanner/lead_scanner_screen.dart';
import '../meeting_management/meeting_management_screen.dart';
import '../messages/messages_screen.dart';
import '../my_agenda/my_agenda_screen.dart';
import '../profile/profile_screen.dart';
import '../schedule_meetings/schedule_meetings_screen.dart';
import '../sessions/sessions_screen.dart';
import '../speakers/speakers_screen.dart';
import '../sponsors/sponsors_screen.dart';

class HomeRouterDelegate extends RouterDelegate
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  final GlobalKey<NavigatorState> _navigatorKey;

  @override
  GlobalKey<NavigatorState>? get navigatorKey => _navigatorKey;

  HomeRouterDelegate() : _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(final BuildContext context) {
    return BlocBuilder<AppRouteBloc, AppRouteState>(
      buildWhen: (final prev, final next) =>
          next.routeConfig.maybeWhen(
            home: (final _) => true,
            orElse: () => false,
          ) &&
          prev.routeConfig != next.routeConfig,
      builder: (final _, final state) => Navigator(
        key: navigatorKey,
        pages: [
          state.routeConfig.when(
            auth: (final _) => const EmptyScreen(),
            home: (final home) => home.when(
              profile: () => const ProfileScreen(),
              dashboard: () => const DashboardScreen(),
              scheduleMeetings: (final _) => const ScheduleMeetingsScreen(),
              meetingManagement: () => const MeetingManagementScreen(),
              sessions: () => const SessionsScreen(),
              myAgenda: () => const MyAgendaScreen(),
              speakers: () => const SpeakersScreen(),
              exhibitors: () => const ExhibitorsScreen(),
              sponsors: () => const SponsorsScreen(),
              messages: (final _) => const MessagesScreen(),
              organization: () => const EditOrganizationScreen(),
              leadScanner: (final _) => const LeadScannerScreen(),
              feeds: () => const FeedsScreen(),
            ),
          ),
        ],
        onPopPage: (final route, final result) {
          if (!route.didPop(result)) return false;
          return true;
        },
      ),
    );
  }

  @override
  SynchronousFuture<void> setNewRoutePath(final configuration) {
    return SynchronousFuture(null);
  }
}
