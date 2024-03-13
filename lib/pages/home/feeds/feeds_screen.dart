import 'package:flutter/material.dart';

import '../../../utils/screen.dart';
import 'feeds_fragment.dart';

class FeedsScreen extends Screen {
  static const ROUTE_NAME = 'feeds';

  const FeedsScreen()
      : super(
          staticAnimation: true,
        );

  @override
  Widget createChild(final BuildContext context) {
    return const FeedsFragment();
  }
}
