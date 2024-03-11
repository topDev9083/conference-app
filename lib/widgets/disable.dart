import 'package:flutter/material.dart';

import '../core/colors.dart';

class Disable extends StatelessWidget {
  final Widget child;
  final bool disable;

  const Disable({
    required this.child,
    this.disable = true,
  });

  @override
  Widget build(final BuildContext context) {
    return ElevatedButtonTheme(
      data: ElevatedButtonThemeData(
        style: ElevatedButtonTheme.of(context).style?.copyWith(
              backgroundColor:
                  disable ? MaterialStateProperty.all(WCColors.grey_b7) : null,
            ),
      ),
      child: child,
    );
  }
}
