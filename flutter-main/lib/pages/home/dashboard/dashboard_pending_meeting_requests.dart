import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../flutter_i18n/translation_keys.dart';
import '../../../widgets/static_grid.dart';
import '../router/home_route_bloc.dart';
import '../router/home_route_config.dart';
import '../schedule_meetings/router/schedule_meetings_route_config.dart';
import 'bloc/dashboard_bloc.dart';
import 'bloc/dashboard_state.dart';
import 'dashboard_meeting_item.dart';
import 'dashboard_section_title.dart';

class DashboardPendingMeetingRequests extends StatelessWidget {
  const DashboardPendingMeetingRequests();

  @override
  Widget build(final BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (final _, final state) => Column(
        children: [
          const SizedBox(height: 33),
          DashboardSectionTitle(
            translate(
              context,
              TranslationKeys.Dashboard_Pending_Meeting_Requests,
            )!,
            onTap: () => HomeRouteBloc.of(context).updateRouteConfig(
              const HomeRouteConfig.scheduleMeetings(
                scheduleMeetingsRouteConfig: ScheduleMeetingsRouteConfig(),
              ),
            ),
          ),
          StaticGrid(
            columns: getValueForScreenType(
              context: context,
              mobile: 1,
              tablet: 2,
            ),
            spacing: 28,
            runSpacing: 28,
            children: state.api.data!.pendingMeetingRequests
                .map((final meeting) => DashboardMeetingItem(meeting))
                .toList(),
          ),
        ],
      ),
    );
  }
}
