import 'package:flutter/material.dart';

import '../../../utils/screen.dart';
import 'login_page.dart';

class LoginScreen extends Screen {
  static const ROUTE_NAME = 'login';

  const LoginScreen();

  @override
  Widget createChild(final BuildContext context) {
    return const LoginPage();
  }
}
