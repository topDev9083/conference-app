import 'package:flutter/material.dart';

import '../core/colors.dart';
import 'image.dart';
import 'ink_well.dart';
import 'trn_text.dart';

class IconLabelButton extends StatelessWidget {
  final VoidCallback? onTap;
  final Color? iconColor;
  final String? labelKey;
  final IconData? icon;
  final String? iconAsset;

  const IconLabelButton({
    this.labelKey,
    this.icon,
    this.iconAsset,
    this.iconColor,
    this.onTap,
  });

  @override
  Widget build(final BuildContext context) {
    return WCInkWell(
      onTap: onTap,
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 8,
      ),
      borderRadius: BorderRadius.circular(999),
      child: Row(
        children: [
          if (icon != null) ...[
            Icon(
              icon,
              color: iconColor ?? WCColors.grey_7a,
              size: 20,
            ),
          ],
          if (iconAsset != null) ...[
            WCImage(
              image: iconAsset,
              width: 20,
              color: iconColor ?? WCColors.grey_7a,
            ),
          ],
          if ((icon != null || iconAsset != null) && labelKey != null) ...[
            const SizedBox(width: 8),
          ],
          if (labelKey != null) ...[
            TrnText(
              labelKey!,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
