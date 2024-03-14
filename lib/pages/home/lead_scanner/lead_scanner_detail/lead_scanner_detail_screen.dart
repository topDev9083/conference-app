import 'package:flutter/material.dart';

import '../../../../utils/screen.dart';
import 'lead_scanner_detail_fragment.dart';

class LeadScannerDetailScreen extends Screen {
  final int selectedUserId;

  LeadScannerDetailScreen({
    required this.selectedUserId,
  }) : super(
          key: ValueKey(selectedUserId),
          staticAnimation: true,
        );

  @override
  Widget createChild(final BuildContext context) {
    return LeadScannerDetailFragment(selectedUserId);
  }
}
