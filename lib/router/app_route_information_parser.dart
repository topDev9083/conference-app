import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

import '../pages/auth/forgot_password/forgot_password_screen.dart';
import '../pages/auth/login/login_screen.dart';
import '../pages/auth/router/auth_route_config.dart';
import '../pages/auth/signup/signup_screen.dart';
import '../pages/home/dashboard/dashboard_screen.dart';
import '../pages/home/edit_organization/edit_organization_screen.dart';
import '../pages/home/exhibitors/exhibitors_screen.dart';
import '../pages/home/feeds/feeds_screen.dart';
import '../pages/home/lead_scanner/lead_scanner_screen.dart';
import '../pages/home/lead_scanner/router/lead_scanner_route_config.dart';
import '../pages/home/meeting_management/meeting_management_screen.dart';
import '../pages/home/messages/messages_screen.dart';
import '../pages/home/messages/router/messages_route_config.dart';
import '../pages/home/my_agenda/my_agenda_screen.dart';
import '../pages/home/profile/profile_screen.dart';
import '../pages/home/router/home_route_config.dart';
import '../pages/home/schedule_meetings/router/schedule_meetings_route_config.dart';
import '../pages/home/schedule_meetings/schedule_meetings_screen.dart';
import '../pages/home/sessions/sessions_screen.dart';
import '../pages/home/speakers/speakers_screen.dart';
import '../pages/home/sponsors/sponsors_screen.dart';
import 'app_route_config.dart';

final _logger = Logger('app_route_information_parser.dart');

class AppRouteInformationParser extends RouteInformationParser<AppRouteConfig> {
  @override
  SynchronousFuture<AppRouteConfig> parseRouteInformation(
    final RouteInformation routeInformation,
  ) {
    _logger.info('parseRouteInformation: ${routeInformation.uri}');
    final uri = routeInformation.uri;
    if (uri.pathSegments.isNotEmpty) {
      switch (uri.pathSegments.first) {
        case LoginScreen.ROUTE_NAME:
          return SynchronousFuture(
            const AppRouteConfig.auth(
              authRouteConfig: AuthRouteConfig.login(),
            ),
          );
        case ForgotPasswordScreen.ROUTE_NAME:
          return SynchronousFuture(
            const AppRouteConfig.auth(
              authRouteConfig: AuthRouteConfig.forgotPassword(),
            ),
          );
        case SignupScreen.ROUTE_NAME:
          return SynchronousFuture(
            const AppRouteConfig.auth(
              authRouteConfig: AuthRouteConfig.signup(),
            ),
          );
        case ProfileScreen.ROUTE_NAME:
          return SynchronousFuture(
            const AppRouteConfig.home(
              homeRouteConfig: HomeRouteConfig.profile(),
            ),
          );
        case DashboardScreen.ROUTE_NAME:
          return SynchronousFuture(
            const AppRouteConfig.home(
              homeRouteConfig: HomeRouteConfig.dashboard(),
            ),
          );
        case ScheduleMeetingsScreen.ROUTE_NAME:
          int? selectedUserId = uri.pathSegments.length == 2
              ? int.tryParse(uri.pathSegments.last)
              : null;
          return SynchronousFuture(
            AppRouteConfig.home(
              homeRouteConfig: HomeRouteConfig.scheduleMeetings(
                scheduleMeetingsRouteConfig: ScheduleMeetingsRouteConfig(
                  selectedUserId: selectedUserId,
                ),
              ),
            ),
          );
        case MeetingManagementScreen.ROUTE_NAME:
          return SynchronousFuture(
            const AppRouteConfig.home(
              homeRouteConfig: HomeRouteConfig.meetingManagement(),
            ),
          );
        case SessionsScreen.ROUTE_NAME:
          return SynchronousFuture(
            const AppRouteConfig.home(
              homeRouteConfig: HomeRouteConfig.sessions(),
            ),
          );
        case MyAgendaScreen.ROUTE_NAME:
          return SynchronousFuture(
            const AppRouteConfig.home(
              homeRouteConfig: HomeRouteConfig.myAgenda(),
            ),
          );
        case SpeakersScreen.ROUTE_NAME:
          return SynchronousFuture(
            const AppRouteConfig.home(
              homeRouteConfig: HomeRouteConfig.speakers(),
            ),
          );
        case ExhibitorsScreen.ROUTE_NAME:
          return SynchronousFuture(
            const AppRouteConfig.home(
              homeRouteConfig: HomeRouteConfig.exhibitors(),
            ),
          );
        case SponsorsScreen.ROUTE_NAME:
          return SynchronousFuture(
            const AppRouteConfig.home(
              homeRouteConfig: HomeRouteConfig.sponsors(),
            ),
          );
        case MessagesScreen.ROUTE_NAME:
          return SynchronousFuture(
            AppRouteConfig.home(
              homeRouteConfig: HomeRouteConfig.messages(
                messagesRouteConfig: MessagesRouteConfig(
                  selectedUserId: uri.pathSegments.length == 2
                      ? int.tryParse(uri.pathSegments.last)
                      : null,
                ),
              ),
            ),
          );
        case EditOrganizationScreen.ROUTE_NAME:
          return SynchronousFuture(
            const AppRouteConfig.home(
              homeRouteConfig: HomeRouteConfig.organization(),
            ),
          );
        case LeadScannerScreen.ROUTE_NAME:
          return SynchronousFuture(
            AppRouteConfig.home(
              homeRouteConfig: HomeRouteConfig.leadScanner(
                leadScannerRouteConfig: LeadScannerRouteConfig(
                  selectedUserId: uri.pathSegments.length == 2
                      ? int.tryParse(uri.pathSegments.last)
                      : null,
                ),
              ),
            ),
          );
        case FeedsScreen.ROUTE_NAME:
          return SynchronousFuture(
            const AppRouteConfig.home(
              homeRouteConfig: HomeRouteConfig.feeds(),
            ),
          );
      }
    }
    return SynchronousFuture(
      const AppRouteConfig.auth(),
    );
  }

  @override
  RouteInformation? restoreRouteInformation(final AppRouteConfig config) {
    _logger.info('restoreRouteInformation: $config');
    return RouteInformation(
      location: config.when(
        auth: (final auth) => auth.when(
          login: () => LoginScreen.ROUTE_NAME,
          signup: () => SignupScreen.ROUTE_NAME,
          forgotPassword: () => ForgotPasswordScreen.ROUTE_NAME,
        ),
        home: (final home) => home.when(
          profile: () => ProfileScreen.ROUTE_NAME,
          dashboard: () => DashboardScreen.ROUTE_NAME,
          scheduleMeetings: (final sm) {
            final uri = Uri(
              path: '${ScheduleMeetingsScreen.ROUTE_NAME}'
                  '${sm.selectedUserId == null ? '' : '/${sm.selectedUserId}'}',
            );
            return uri.toString();
          },
          meetingManagement: () => MeetingManagementScreen.ROUTE_NAME,
          sessions: () => SessionsScreen.ROUTE_NAME,
          myAgenda: () => MyAgendaScreen.ROUTE_NAME,
          speakers: () => SpeakersScreen.ROUTE_NAME,
          exhibitors: () => ExhibitorsScreen.ROUTE_NAME,
          sponsors: () => SponsorsScreen.ROUTE_NAME,
          messages: (final messages) => Uri(
            path: '${MessagesScreen.ROUTE_NAME}'
                '${messages.selectedUserId == null ? '' : '/${messages.selectedUserId}'}',
          ).toString(),
          organization: () => EditOrganizationScreen.ROUTE_NAME,
          leadScanner: (final ls) => Uri(
            path: '${LeadScannerScreen.ROUTE_NAME}'
                '${ls.selectedUserId == null ? '' : '/${ls.selectedUserId}'}',
          ).toString(),
          feeds: () => FeedsScreen.ROUTE_NAME,
        ),
      ),
    );
  }
}
