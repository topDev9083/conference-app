import 'package:flutter/material.dart';

import '../../../flutter_i18n/translation_keys.dart';
import '../../../widgets/ink_well.dart';

class DashboardSectionTitle extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;

  const DashboardSectionTitle(
    this.title, {
    this.onTap,
  });

  @override
  Widget build(final BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        WCInkWell(
          padding: const EdgeInsets.all(8),
          onTap: onTap,
          child: Text(
            translate(context, TranslationKeys.Dashboard_View_All)!,
            style: TextStyle(
              fontSize: 12,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
