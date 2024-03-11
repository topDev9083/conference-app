import 'package:flutter/material.dart';

import '../../../utils/screen.dart';
import 'signup_page.dart';

class SignupScreen extends Screen {
  static const ROUTE_NAME = 'signup';

  const SignupScreen();

  @override
  Widget createChild(final BuildContext context) {
    return const SignupPage();
  }
}
