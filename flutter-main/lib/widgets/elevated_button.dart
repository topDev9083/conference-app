import 'package:flutter/material.dart';

import '../flutter_i18n/translation_keys.dart';
import '../utils/responsive_utils.dart';
import 'progress_indicator.dart';

class WCElevatedButton extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final bool showLoader;
  final Color? backgroundColor;

  const WCElevatedButton(
    this.title, {
    this.onTap,
    this.backgroundColor,
    this.showLoader = false,
  });

  @override
  Widget build(final BuildContext context) {
    final child = ElevatedButton(
      onPressed: showLoader ? () {} : onTap,
      style: ButtonStyle(
        backgroundColor: backgroundColor == null
            ? null
            : MaterialStateProperty.all(backgroundColor),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showLoader) ...[
            WCProgressIndicator.small(
              color: Colors.white,
            ),
            const SizedBox(width: 16),
          ],
          Text(
            showLoader
                ? translate(context, TranslationKeys.General_Please_Wait)!
                : title,
          ),
        ],
      ),
    );
    if (ScreenType.of(context).isMobile) {
      return ElevatedButtonTheme(
        data: ElevatedButtonThemeData(
          style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
                padding: MaterialStateProperty.all(
                  const EdgeInsets.symmetric(
                    vertical: 14,
                    horizontal: 20,
                  ),
                ),
              ),
        ),
        child: child,
      );
    } else {
      return child;
    }
  }
}
