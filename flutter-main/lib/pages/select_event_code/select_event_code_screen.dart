import 'package:flutter/material.dart';

import '../../utils/screen.dart';
import 'select_event_code_page.dart';

class SelectEventCodeScreen extends Screen {
  const SelectEventCodeScreen();

  @override
  Widget createChild(final BuildContext context) {
    return const SelectEventCodePage();
  }
}
