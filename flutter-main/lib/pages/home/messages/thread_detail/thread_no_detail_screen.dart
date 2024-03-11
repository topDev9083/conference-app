import 'package:flutter/material.dart';

import '../../../../utils/screen.dart';
import 'thread_no_detail_fragment.dart';

class ThreadNoDetailScreen extends Screen {
  const ThreadNoDetailScreen()
      : super(
          staticAnimation: true,
        );

  @override
  Widget createChild(final BuildContext context) {
    return ThreadNoDetailFragment();
  }
}
