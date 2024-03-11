import 'package:freezed_annotation/freezed_annotation.dart';

import '../lead_scanner/router/lead_scanner_route_config.dart';
import '../messages/router/messages_route_config.dart';
import '../schedule_meetings/router/schedule_meetings_route_config.dart';

part 'home_route_config.freezed.dart';

@freezed
class HomeRouteConfig with _$HomeRouteConfig {
  const factory HomeRouteConfig.profile() = _HomeRouteConfigProfile;

  const factory HomeRouteConfig.dashboard() = _HomeRouteConfigDashboard;

  const factory HomeRouteConfig.scheduleMeetings({
    @Default(ScheduleMeetingsRouteConfig())
        final ScheduleMeetingsRouteConfig scheduleMeetingsRouteConfig,
  }) = _HomeRouteConfigScheduleMeetings;

  const factory HomeRouteConfig.meetingManagement() =
      _HomeRouteConfigMeetingManagement;

  const factory HomeRouteConfig.sessions() = _HomeRouteConfigSessions;

  const factory HomeRouteConfig.myAgenda() = _HomeRouteConfigMyAgenda;

  const factory HomeRouteConfig.speakers() = _HomeRouteConfigSpeakers;

  const factory HomeRouteConfig.exhibitors() = _HomeRouteConfigExhibitors;

  const factory HomeRouteConfig.sponsors() = _HomeRouteConfigSponsors;

  const factory HomeRouteConfig.messages({
    @Default(MessagesRouteConfig())
        final MessagesRouteConfig messagesRouteConfig,
  }) = _HomeRouteConfigMessages;

  const factory HomeRouteConfig.organization() = _HomeRouteConfigOrganization;

  const factory HomeRouteConfig.feeds() = _HomeRouteConfigFeeds;

  const factory HomeRouteConfig.leadScanner({
    @Default(LeadScannerRouteConfig())
        final LeadScannerRouteConfig leadScannerRouteConfig,
  }) = _HomeRouteConfigLeadScanner;
}
