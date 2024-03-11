import 'package:flutter/material.dart';

import '../flutter_i18n/translation_keys.dart';
import 'elevated_button.dart';
import 'image.dart';

class WCDialog extends StatelessWidget {
  final String? image;
  final String? title;
  final String? subtitle;
  final String? positiveButtonText;
  final String? negativeButtonText;
  final VoidCallback? onTapPositive;
  final VoidCallback? onTapNegative;

  const WCDialog({
    this.image,
    this.title,
    this.subtitle,
    this.positiveButtonText,
    this.negativeButtonText,
    this.onTapPositive,
    this.onTapNegative,
  });

  static Future<bool> show(
    final BuildContext context, {
    final bool barrierDismissible = true,
    final String? image,
    final String? title,
    final String? subtitle,
    final String? positiveButtonText,
    final String? negativeButtonText,
    final VoidCallback? onTapPositive,
    final VoidCallback? onTapNegative,
  }) async {
    final isYes = await showDialog<bool>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (final _) => Dialog(
        backgroundColor: Colors.transparent,
        child: WCDialog(
          image: image,
          title: title,
          subtitle: subtitle,
          positiveButtonText: positiveButtonText,
          negativeButtonText: negativeButtonText,
          onTapPositive: onTapPositive,
          onTapNegative: onTapNegative,
        ),
      ),
    );
    return isYes == true;
  }

  static Future<bool> showInfo(
    final BuildContext context, {
    final String? image,
    final String? title,
    final String? subtitle,
  }) {
    return show(
      context,
      image: image,
      title: title,
      subtitle: subtitle,
      positiveButtonText: translate(context, TranslationKeys.General_Ok),
    );
  }

  static Future<bool> showError(
    final BuildContext context, {
    final String? title,
    final String? subtitle,
  }) {
    return showInfo(
      context,
      image: 'il_error.png',
      title: title ?? translate(context, TranslationKeys.General_Error),
      subtitle: subtitle,
    );
  }

  @override
  Widget build(final BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 58,
        vertical: 43,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (image != null) ...[
            WCImage(
              image: image!,
              height: 142,
              fit: BoxFit.fill,
            ),
          ],
          if (title != null) ...[
            const SizedBox(height: 13),
            Text(
              title!,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
          if (subtitle != null) ...[
            const SizedBox(height: 18),
            Text(
              subtitle!,
              textAlign: TextAlign.center,
            ),
          ],
          const SizedBox(height: 20),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (positiveButtonText != null) ...[
                WCElevatedButton(
                  positiveButtonText!,
                  onTap: onTapPositive ?? () => Navigator.of(context).pop(true),
                ),
              ],
              if (positiveButtonText != null && negativeButtonText != null) ...[
                const SizedBox(width: 23),
              ],
              if (negativeButtonText != null) ...[
                WCElevatedButton(
                  negativeButtonText!,
                  backgroundColor: Colors.transparent,
                  onTap: onTapNegative ?? Navigator.of(context).pop,
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
