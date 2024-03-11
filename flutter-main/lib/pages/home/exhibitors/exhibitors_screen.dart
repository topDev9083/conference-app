import 'package:flutter/material.dart';

import '../../../utils/screen.dart';
import 'exhibitors_fragment.dart';

class ExhibitorsScreen extends Screen {
  static const ROUTE_NAME = 'exhibitors';

  const ExhibitorsScreen()
      : super(
          staticAnimation: true,
        );

  @override
  Widget createChild(final BuildContext context) {
    return const ExhibitorsFragment();
  }
}
