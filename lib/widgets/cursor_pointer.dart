import 'package:flutter/material.dart';

class CursorPointer extends StatelessWidget {
  final Widget? child;

  const CursorPointer({
    this.child,
  });

  @override
  Widget build(final BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: child,
    );
  }
}
