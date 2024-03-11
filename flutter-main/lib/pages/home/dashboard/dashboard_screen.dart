import 'package:flutter/material.dart';

import '../../../utils/screen.dart';
import 'dashboard_fragment.dart';

class DashboardScreen extends Screen {
  static const ROUTE_NAME = 'dashboard';

  const DashboardScreen()
      : super(
          staticAnimation: true,
        );

  @override
  Widget createChild(final BuildContext context) {
    return const DashboardFragment();
  }
}
