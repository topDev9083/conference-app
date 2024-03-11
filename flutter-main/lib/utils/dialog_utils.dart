import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../flutter_i18n/translation_keys.dart';
import '../widgets/trn_text.dart';

class DialogUtils {
  const DialogUtils._();

  static Future<bool> showAdaptiveDialog(
    final BuildContext context, {
    final String? title,
    final String? content,
    final String? positiveTextKey,
    final String? negativeTextKey,
    final VoidCallback? onPositive,
    final VoidCallback? onNegative,
    final bool? isDestructive,
  }) async {
    final tTitle = title == null ? null : Text(title);
    final tContent = content == null ? null : Text(content);
    final tPositive = positiveTextKey == null
        ? null
        : Text(
            translate(context, positiveTextKey)!,
          );
    final tNegative = negativeTextKey == null
        ? null
        : Text(
            translate(context, negativeTextKey)!,
          );
    bool? result;
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      result = await showCupertinoDialog<bool>(
        context: context,
        barrierDismissible: true,
        builder: (final context) => CupertinoAlertDialog(
          title: tTitle,
          content: tContent,
          actions: [
            if (tNegative != null) ...[
              CupertinoDialogAction(
                onPressed: () {
                  onNegative?.call();
                  Navigator.pop(context, false);
                },
                child: tNegative,
              ),
            ],
            if (tPositive != null) ...[
              CupertinoDialogAction(
                isDestructiveAction: isDestructive ?? false,
                onPressed: () {
                  onPositive?.call();
                  Navigator.pop(context, true);
                },
                child: tPositive,
              ),
            ],
          ],
        ),
      );
    } else {
      result = await showDialog(
        context: context,
        builder: (final context) => AlertDialog(
          title: tTitle,
          content: tContent,
          actions: [
            if (tNegative != null) ...[
              TextButton(
                onPressed: () {
                  onNegative?.call();
                  Navigator.pop(context, false);
                },
                child: tNegative,
              ),
            ],
            if (tPositive != null) ...[
              TextButton(
                onPressed: () {
                  onPositive?.call();
                  Navigator.pop(context, true);
                },
                child: tPositive,
              ),
            ],
          ],
        ),
      );
    }
    return result == true;
  }

  static Future<bool> showInfoDialog(
    final BuildContext context, {
    final String? title,
    final String? content,
  }) {
    return showAdaptiveDialog(
      context,
      title: title,
      content: content,
      positiveTextKey: TranslationKeys.General_Ok,
    );
  }

  static Future<bool> showErrorDialog(
    final BuildContext context, {
    final String? content,
  }) {
    return showAdaptiveDialog(
      context,
      title: translate(context, TranslationKeys.General_Error),
      content: content,
      positiveTextKey: TranslationKeys.General_Ok,
    );
  }

  static Future<bool> showConfirmationDialog(
    final BuildContext context, {
    final String? title,
    final String? content,
    final bool? isDestructive,
  }) {
    return showAdaptiveDialog(
      context,
      title: title,
      content:
          content ?? translate(context, TranslationKeys.General_Are_You_Sure),
      positiveTextKey: TranslationKeys.General_Yes,
      negativeTextKey: TranslationKeys.General_No,
      isDestructive: isDestructive,
    );
  }

  static Future<String?> showCupertinoTextFieldDialog(
    final BuildContext context, {
    final String? titleKey,
    final String? text,
  }) {
    final controller = TextEditingController(
      text: text,
    );
    return showCupertinoDialog<String>(
      barrierDismissible: true,
      context: context,
      builder: (final context) => CupertinoAlertDialog(
        title: titleKey != null
            ? Padding(
                padding: const EdgeInsets.only(
                  bottom: 16,
                ),
                child: Text(
                  translate(context, titleKey)!,
                ),
              )
            : null,
        content: CupertinoTextField(
          controller: controller,
          autofocus: true,
          clearButtonMode: OverlayVisibilityMode.always,
        ),
        actions: [
          CupertinoDialogAction(
            child: const TrnText(
              TranslationKeys.General_Cancel,
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
            onPressed: () => Navigator.pop(context),
          ),
          CupertinoDialogAction(
            child: const TrnText(
              TranslationKeys.General_Save,
            ),
            onPressed: () => Navigator.pop(
              context,
              controller.text,
            ),
          ),
        ],
      ),
    );
  }
}
