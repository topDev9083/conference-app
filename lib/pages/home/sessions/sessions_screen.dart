import 'package:flutter/material.dart';

import '../../../utils/screen.dart';
import 'sessions_fragment.dart';

class SessionsScreen extends Screen {
  static const ROUTE_NAME = 'sessions';

  const SessionsScreen()
      : super(
          staticAnimation: true,
        );

  @override
  Widget createChild(final BuildContext context) {
    return const SessionsFragment();
  }
}
