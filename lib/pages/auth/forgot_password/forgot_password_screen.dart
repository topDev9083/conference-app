import 'package:flutter/material.dart';

import '../../../utils/screen.dart';
import 'forgot_password_page.dart';

class ForgotPasswordScreen extends Screen {
  static const ROUTE_NAME = 'forgot-password';

  const ForgotPasswordScreen();

  @override
  Widget createChild(final BuildContext context) {
    return const ForgotPasswordPage();
  }
}
