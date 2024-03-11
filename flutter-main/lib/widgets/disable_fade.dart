import 'package:flutter/material.dart';

class DisableFade extends StatelessWidget {
  final Widget? child;
  final bool disable;

  const DisableFade({
    this.child,
    this.disable = true,
  });

  @override
  Widget build(final BuildContext context) {
    return Opacity(
      opacity: disable ? 0.4 : 1,
      child: child,
    );
  }
}
