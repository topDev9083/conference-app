import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../core/colors.dart';
import '../flutter_i18n/translation_keys.dart';

class GreyHeader extends StatelessWidget {
  final String titleKey;
  final String subtitleKey;

  const GreyHeader({
    required this.titleKey,
    required this.subtitleKey,
  });

  @override
  Widget build(final BuildContext context) {
    return Container(
      color: WCColors.grey_f1,
      padding: getValueForScreenType(
        context: context,
        mobile: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        tablet: const EdgeInsets.symmetric(
          horizontal: 53,
          vertical: 18,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(translate(context, titleKey)!),
          const SizedBox(height: 4),
          Text(
            translate(context, subtitleKey)!,
            style: TextStyle(
              fontSize: 12,
              color: WCColors.black_09.withOpacity(0.5),
            ),
          ),
        ],
      ),
    );
  }
}
