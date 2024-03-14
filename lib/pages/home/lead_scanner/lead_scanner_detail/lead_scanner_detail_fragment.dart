import 'package:flutter/material.dart';

import '../../schedule_meetings/schedule_meeting_detail/schedule_meeting_detail_fragment.dart';
import '../router/lead_scanner_route_bloc.dart';

class LeadScannerDetailFragment extends StatelessWidget {
  final int userId;

  const LeadScannerDetailFragment(this.userId);

  @override
  Widget build(final BuildContext context) {
    return ScheduleMeetingDetailFragment(
      userId,
      onClose: () =>
          LeadScannerRouteBloc.of(context).updateSelectedUserid(null),
    );
  }
}
