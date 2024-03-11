import 'package:flutter/material.dart';

class WCInkWell extends StatelessWidget {
  final Widget? child;
  final VoidCallback? onTap;
  final bool isDark;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;
  final Color? hoverColor;
  final bool isCircle;
  final bool isOverLay;
  final bool showInkWellRipple;

  const WCInkWell({
    this.child,
    this.isDark = false,
    this.onTap,
    this.borderRadius,
    this.padding,
    this.hoverColor,
    this.isCircle = false,
    this.isOverLay = false,
    this.showInkWellRipple = true,
  });

  @override
  Widget build(final BuildContext context) {
    final inkWell = Material(
      color: Colors.transparent,
      textStyle: DefaultTextStyle.of(context).style,
      child: InkWell(
        borderRadius: isCircle ? BorderRadius.circular(999) : borderRadius,
        splashColor: !showInkWellRipple
            ? Colors.transparent
            : isDark
                ? Colors.white.withOpacity(0.2)
                : Colors.black.withOpacity(0.1),
        highlightColor: Colors.black.withOpacity(isDark ? 0.2 : 0.05),
        onTap: onTap,
        hoverColor: hoverColor ??
            (isDark ? Colors.white : Colors.black)
                .withOpacity(isDark ? 0.2 : 0.05),
        child: isOverLay
            ? null
            : Padding(
                padding: padding ?? EdgeInsets.zero,
                child: child,
              ),
      ),
    );
    if (isOverLay) {
      return Stack(
        children: [
          if (child != null) ...[
            Padding(
              padding: padding ?? EdgeInsets.zero,
              child: child,
            ),
          ],
          Positioned.fill(
            child: inkWell,
          ),
        ],
      );
    } else {
      return inkWell;
    }
  }
}
