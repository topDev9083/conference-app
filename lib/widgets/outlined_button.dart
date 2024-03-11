import 'package:flutter/material.dart';

import '../flutter_i18n/translation_keys.dart';
import 'image.dart';
import 'progress_indicator.dart';

class WCOutlinedButton extends StatelessWidget {
  final String? title;
  final String? iconPng;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? textColor;
  final bool showLoader;
  final WCOutlinedButtonType? type;

  const WCOutlinedButton({
    this.title,
    this.iconPng,
    this.onTap,
    this.backgroundColor,
    this.borderColor,
    this.textColor,
    this.type,
    this.showLoader = false,
  });

  @override
  Widget build(final BuildContext context) {
    return OutlinedButton(
      onPressed: onTap,
      style: ButtonStyle(
        padding: () {
          switch (type) {
            case WCOutlinedButtonType.bigA:
              return MaterialStateProperty.all(
                const EdgeInsets.symmetric(
                  horizontal: 70,
                  vertical: 16,
                ),
              );
            case WCOutlinedButtonType.bigV:
              return MaterialStateProperty.all(
                const EdgeInsets.symmetric(
                  vertical: 16,
                ),
              );
            default:
              return null;
          }
        }(),
        backgroundColor: backgroundColor == null
            ? null
            : MaterialStateProperty.all(backgroundColor),
        side: borderColor == null
            ? null
            : MaterialStateProperty.all(
                BorderSide(
                  color: borderColor ?? Colors.black,
                ),
              ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showLoader) ...[
            WCProgressIndicator.small(
              color: textColor ?? borderColor ?? Theme.of(context).primaryColor,
            ),
            const SizedBox(width: 16),
          ],
          if (!showLoader && iconPng != null) ...[
            WCImage(
              image: iconPng!,
              width: 16,
              color: textColor ?? borderColor ?? Theme.of(context).primaryColor,
            ),
          ],
          if (!showLoader && iconPng != null && title != null) ...[
            const SizedBox(width: 9),
          ],
          if (title != null) ...[
            Text(
              showLoader
                  ? translate(context, TranslationKeys.General_Please_Wait)!
                  : title!,
              style: TextStyle(
                color: textColor ?? borderColor,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

enum WCOutlinedButtonType {
  normal,
  bigA,
  bigV,
}
