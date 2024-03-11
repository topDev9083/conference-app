import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:url_launcher/url_launcher.dart' show LaunchMode;

import '../../../bloc/event_bloc.dart';
import '../../../bloc/state/event_state.dart';
import '../../../models/data/event_data.dart';
import '../../../utils/url_lanuncher.dart';
import '../../../widgets/connection_information.dart';
import '../../../widgets/fragment_padding.dart';
import '../../../widgets/image.dart';
import '../../../widgets/ink_well.dart';
import 'bloc/dashboard_bloc.dart';
import 'bloc/dashboard_state.dart';
import 'dashboard_attendees.dart';
import 'dashboard_featured_sessions.dart';
import 'dashboard_meetings_scheduled.dart';
import 'dashboard_pending_meeting_requests.dart';
import 'dashboard_speakers.dart';

class DashboardFragment extends StatelessWidget {
  const DashboardFragment();

  @override
  Widget build(final BuildContext _) {
    return BlocProvider<DashboardBloc>(
      create: (final _) => DashboardBloc(),
      child: BlocBuilder<DashboardBloc, DashboardState>(
        builder: (final context, final state) => state.api.data == null
            ? Center(
                child: ConnectionInformation(
                  error: state.api.error,
                  onRetry: DashboardBloc.of(context).getDashboardInfo,
                ),
              )
            : ListView(
                padding: const EdgeInsets.only(
                  bottom: 25,
                ),
                children: [
                  const _EventCover(),
                  FragmentPadding(
                    child: ScreenTypeLayout.builder(
                      mobile: (final _) => const Column(
                        children: [
                          _LeftColumn(),
                          _RightColumn(),
                        ],
                      ),
                      tablet: (final _) => const Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            flex: 9,
                            child: _LeftColumn(),
                          ),
                          SizedBox(
                            width: 27,
                          ),
                          Flexible(
                            flex: 5,
                            child: _RightColumn(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

class _EventCover extends StatelessWidget {
  const _EventCover();

  @override
  Widget build(final BuildContext context) {
    return BlocSelector<EventBloc, EventState, EventData>(
      selector: (final state) => state.getEventApi.data!,
      builder: (final _, final event) => Padding(
        padding: EdgeInsets.symmetric(
          horizontal: getValueForScreenType(
            context: context,
            mobile: 0,
            tablet: 26,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(
            getValueForScreenType(
              context: context,
              mobile: 0,
              tablet: 7,
            ),
          ),
          child: Stack(
            children: [
              if (event.appConfig.coverImage != null) ...[
                WCImage(
                  image: event.appConfig.coverImage!,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ] else ...[
                Container(
                  width: double.infinity,
                  height: 200,
                  color: Colors.black,
                  alignment: Alignment.center,
                  child: Text(
                    event.name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                    ),
                  ),
                ),
              ],
              if (event.address != null) ...[
                Positioned.fill(
                  bottom: 12,
                  left: 8,
                  right: 8,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: WCInkWell(
                      padding: event.locationMapUrl == null
                          ? null
                          : const EdgeInsets.all(8),
                      onTap: event.locationMapUrl == null
                          ? null
                          : () {
                              launchUrl(
                                event.locationMapUrl!,
                                mode: LaunchMode.externalApplication,
                              );
                            },
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                          children: [
                            const WidgetSpan(
                              child: Padding(
                                padding: EdgeInsetsDirectional.only(end: 8),
                                child: WCImage(
                                  image: 'ic_pin.png',
                                  height: 13,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            TextSpan(
                              text: event.address,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _LeftColumn extends StatelessWidget {
  const _LeftColumn();

  @override
  Widget build(final BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (final _, final state) => Column(
        children: [
          if (state.api.data!.sessions.isNotEmpty) ...[
            const DashboardFeaturedSessions(),
          ],
          if (state.api.data!.pendingMeetingRequests.isNotEmpty) ...[
            const DashboardPendingMeetingRequests(),
          ],
          if (state.api.data!.acceptedMeetings.isNotEmpty) ...[
            const DashboardMeetingsScheduled(),
          ],
        ],
      ),
    );
  }
}

class _RightColumn extends StatelessWidget {
  const _RightColumn();

  @override
  Widget build(final BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (final _, final state) => Column(
        children: [
          if (state.api.data!.users.isNotEmpty) ...[
            const DashboardAttendees(),
          ],
          if (state.api.data!.speakers.isNotEmpty) ...[
            const DashboardSpeakers(),
          ],
        ],
      ),
    );
  }
}
