import 'package:flutter/material.dart';

import '../../../utils/screen.dart';
import 'profile_fragment.dart';

class ProfileScreen extends Screen {
  static const ROUTE_NAME = 'profile';

  const ProfileScreen()
      : super(
          staticAnimation: true,
        );

  @override
  Widget createChild(final BuildContext context) {
    return const ProfileFragment();
  }
}
