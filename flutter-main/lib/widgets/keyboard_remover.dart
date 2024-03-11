import 'package:flutter/material.dart';

class KeyboardRemover extends StatelessWidget {
  final Widget child;

  const KeyboardRemover({
    required this.child,
  });

  @override
  Widget build(final BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: child,
    );
  }
}
