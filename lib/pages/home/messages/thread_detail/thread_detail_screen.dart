import 'package:flutter/material.dart';

import '../../../../utils/screen.dart';
import 'thread_detail_fragment.dart';

class ThreadDetailScreen extends Screen {
  final int selectedUserId;

  ThreadDetailScreen({
    required this.selectedUserId,
  }) : super(
          key: ValueKey(selectedUserId),
          staticAnimation: true,
        );

  @override
  Widget createChild(final BuildContext context) {
    return ThreadDetailFragment(selectedUserId);
  }
}
