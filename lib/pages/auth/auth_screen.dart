import 'package:flutter/material.dart';

import '../../utils/screen.dart';
import 'auth_page.dart';

class AuthScreen extends Screen {
  static const ROUTE_NAME = '/';

  const AuthScreen()
      : super(
          staticAnimation: true,
        );

  @override
  Widget createChild(final BuildContext context) {
    return const AuthPage();
  }
}
