import 'package:flutter/cupertino.dart';

import '../flutter_i18n/translation_keys.dart';
import '../widgets/trn_text.dart';

class BottomSheetUtils {
  const BottomSheetUtils._();

  static Future<int?> showOptions(
    final BuildContext context, {
    final String? message,
    required final List<BottomSheetOption> options,
  }) {
    return showCupertinoModalPopup<int>(
      context: context,
      builder: (final context) => CupertinoActionSheet(
        actions: [
          for (int i = 0; i < options.length; i++) ...[
            CupertinoActionSheetAction(
              onPressed: () {
                Navigator.pop(context, i);
              },
              isDestructiveAction: options[i].isDestructive,
              child: TrnText(options[i].textKey),
            ),
          ],
        ],
        cancelButton: CupertinoActionSheetAction(
          onPressed: Navigator.of(context).pop,
          child: const TrnText(TranslationKeys.General_Close),
        ),
      ),
    );
  }
}

class BottomSheetOption {
  final String textKey;
  final bool isDestructive;

  BottomSheetOption(
    this.textKey, {
    this.isDestructive = false,
  });
}
