import 'package:flutter/material.dart';

import '../../../utils/screen.dart';
import 'my_agenda_fragment.dart';

class MyAgendaScreen extends Screen {
  static const ROUTE_NAME = 'my-agenda';

  const MyAgendaScreen()
      : super(
          staticAnimation: true,
        );

  @override
  Widget createChild(final BuildContext context) {
    return const MyAgendaFragment();
  }
}
