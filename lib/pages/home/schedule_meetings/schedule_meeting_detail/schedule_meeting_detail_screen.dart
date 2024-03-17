import 'package:flutter/material.dart';

import '../../../../utils/screen.dart';
import '../router/schedule_meetings_route_bloc.dart';
import 'schedule_meeting_detail_fragment.dart';

class ScheduleMeetingDetailScreen extends Screen {
  final int userId;

  ScheduleMeetingDetailScreen({
    required this.userId,
  }) : super(
          key: ValueKey(userId),
          staticAnimation: true,
        );

  @override
  Widget createChild(final BuildContext context) {
    return ScheduleMeetingDetailFragment(
      userId,
      onClose: () =>
          ScheduleMeetingsRouteBloc.of(context).updateSelectedUserId(null),
    );
  }
}
