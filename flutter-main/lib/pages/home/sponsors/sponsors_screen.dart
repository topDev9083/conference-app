import 'package:flutter/material.dart';

import '../../../utils/screen.dart';
import 'sponsors_fragment.dart';

class SponsorsScreen extends Screen {
  static const ROUTE_NAME = 'sponsors';

  const SponsorsScreen()
      : super(
          staticAnimation: true,
        );

  @override
  Widget createChild(final BuildContext context) {
    return const SponsorsFragment();
  }
}
