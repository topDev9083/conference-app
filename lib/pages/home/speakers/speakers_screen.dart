import 'package:flutter/material.dart';

import '../../../utils/screen.dart';
import 'speakers_fragment.dart';

class SpeakersScreen extends Screen {
  static const ROUTE_NAME = 'speakers';

  const SpeakersScreen()
      : super(
          staticAnimation: true,
        );

  @override
  Widget createChild(final BuildContext context) {
    return SpeakersFragment();
  }
}
