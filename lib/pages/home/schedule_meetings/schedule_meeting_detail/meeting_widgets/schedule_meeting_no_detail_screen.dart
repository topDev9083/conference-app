import 'package:flutter/material.dart';

import '../../../../../utils/screen.dart';
import '../schedule_meeting_no_detail_fragment.dart';

class ScheduleMeetingNoDetailScreen extends Screen {
  const ScheduleMeetingNoDetailScreen()
      : super(
    staticAnimation: true,
  );

  @override
  Widget createChild(final BuildContext context) {
    return const ScheduleMeetingNoDetailFragment();
  }
}
