import 'package:flutter/material.dart';

import '../../../../utils/screen.dart';
import 'lead_scanner_no_detail_fragment.dart';

class LeadScannerNoDetailScreen extends Screen {
  const LeadScannerNoDetailScreen()
      : super(
          staticAnimation: true,
        );

  @override
  Widget createChild(final BuildContext context) {
    return const LeadScannerNoDetailFragment();
  }
}
