import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../core/colors.dart';
import '../hover_text.dart';
import '../image.dart';

class IconValue extends StatelessWidget {
  final String icon;
  final String name;
  final String value;
  final VoidCallback? onTap;

  const IconValue({
    required this.icon,
    required this.name,
    required this.value,
    this.onTap,
  });

  @override
  Widget build(final BuildContext context) {
    return Row(
      children: [
        WCImage(
          image: '$icon.png',
          width: getValueForScreenType(
            context: context,
            mobile: 14,
            desktop: 16,
          ),
          color: WCColors.black_09.withOpacity(0.5),
        ),
        const SizedBox(width: 7),
        HoverText(
          name,
          active: onTap != null,
          style: TextStyle(
            fontWeight: getValueForScreenType(
              context: context,
              mobile: FontWeight.w600,
              desktop: FontWeight.w800,
            ),
            fontSize: getValueForScreenType(
              context: context,
              mobile: 14,
              desktop: 16,
            ),
            color: WCColors.black_09.withOpacity(0.5),
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: onTap,
            child: HoverText(
              value,
              active: onTap != null,
              style: TextStyle(
                fontWeight: getValueForScreenType(
                  context: context,
                  mobile: FontWeight.w400,
                  desktop: FontWeight.w600,
                ),
                fontSize: getValueForScreenType(
                  context: context,
                  mobile: 12,
                  desktop: 14,
                ),
                color: WCColors.black_09.withOpacity(0.5),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
