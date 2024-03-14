import 'package:flutter/material.dart';

import '../../../utils/screen.dart';
import 'meeting_management_fragment.dart';

class MeetingManagementScreen extends Screen {
  static const ROUTE_NAME = 'meeting-management';

  const MeetingManagementScreen()
      : super(
          staticAnimation: true,
        );

  @override
  Widget createChild(final BuildContext context) {
    return const MeetingManagementFragment();
  }
}
