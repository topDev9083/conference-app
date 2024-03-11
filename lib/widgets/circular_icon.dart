import 'package:flutter/material.dart';

import 'image.dart';
import 'ink_well.dart';

class CircularIcon extends StatelessWidget {
  final String icon;
  final Color? bgColor;
  final Color? fgColor;
  final VoidCallback? onTap;
  final double? size;
  final String? message;
  final bool isLoading;

  const CircularIcon(
    this.icon, {
    this.bgColor,
    this.fgColor,
    this.onTap,
    this.size,
    this.message,
    this.isLoading = false,
  });

  @override
  Widget build(final BuildContext context) {
    if (isLoading) {
      return SizedBox(
        width: size,
        height: size,
        child: const CircularProgressIndicator(
          strokeWidth: 2,
        ),
      );
    }
    final stack = Stack(
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: bgColor,
            shape: BoxShape.circle,
          ),
          padding: const EdgeInsets.all(5),
          child: WCImage(
            image: '$icon.png',
            color: fgColor,
          ),
        ),
        Positioned.fill(
          child: WCInkWell(
            isDark: true,
            borderRadius: BorderRadius.circular(999),
            onTap: onTap,
          ),
        ),
      ],
    );
    if (message == null) {
      return stack;
    }
    return Tooltip(
      message: message!,
      child: stack,
    );
  }
}
