import 'package:flutter/material.dart';

class WCProgressIndicator extends StatelessWidget {
  final double? size;
  final Color? color;
  final double? strokeWidth;

  const WCProgressIndicator({
    this.size,
    this.color,
    this.strokeWidth,
  });

  factory WCProgressIndicator.small({
    final double? size,
    final Color? color,
    final double? strokeWidth,
  }) =>
      WCProgressIndicator(
        size: size ?? 15,
        color: color,
        strokeWidth: strokeWidth ?? 2,
      );

  @override
  Widget build(final BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator(
        strokeWidth: strokeWidth ?? 4,
        valueColor: color == null ? null : AlwaysStoppedAnimation(color),
      ),
    );
  }
}
