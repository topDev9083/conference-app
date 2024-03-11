import 'package:flutter/material.dart';

import '../../utils/screen.dart';

class EmptyScreen extends Screen {
  const EmptyScreen();

  @override
  Widget createChild(final BuildContext context) {
    return const SizedBox();
  }
}
