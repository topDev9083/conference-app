import 'package:flutter/material.dart';

import '../../../utils/screen.dart';
import 'edit_organization_fragment.dart';

class EditOrganizationScreen extends Screen {
  static const ROUTE_NAME = 'organization';

  const EditOrganizationScreen()
      : super(
          staticAnimation: true,
        );

  @override
  Widget createChild(final BuildContext context) {
    return const EditOrganizationFragment();
  }
}
