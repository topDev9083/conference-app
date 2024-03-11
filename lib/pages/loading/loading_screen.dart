import 'package:flutter/material.dart';

import '../../utils/screen.dart';
import 'loading_page.dart';

class LoadingScreen extends Screen {
  const LoadingScreen();

  @override
  Widget createChild(final BuildContext context) {
    return const LoadingPage();
  }
}
