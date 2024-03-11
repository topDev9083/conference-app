import 'package:flutter/material.dart';

class WCRowColumn extends StatelessWidget {
  final bool isRow;
  final List<Widget> children;
  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final CrossAxisAlignment crossAxisAlignment;

  const WCRowColumn({
    this.isRow = true,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.max,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    required this.children,
  });

  @override
  Widget build(final BuildContext context) {
    return isRow
        ? Row(
            mainAxisAlignment: mainAxisAlignment,
            crossAxisAlignment: crossAxisAlignment,
            mainAxisSize: mainAxisSize,
            children: children,
          )
        : Column(
            mainAxisAlignment: mainAxisAlignment,
            crossAxisAlignment: crossAxisAlignment,
            mainAxisSize: mainAxisSize,
            children: children,
          );
  }
}

class WCExpanded extends StatelessWidget {
  final Widget child;
  final bool expand;

  const WCExpanded({
    required this.child,
    this.expand = true,
  });

  @override
  Widget build(final BuildContext context) {
    return expand
        ? Expanded(
            child: child,
          )
        : child;
  }
}

class WCSizedBox extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final bool sized;

  const WCSizedBox({
    required this.child,
    this.width,
    this.height,
    this.sized = true,
  });

  @override
  Widget build(final BuildContext context) {
    return sized
        ? SizedBox(
            width: width,
            height: height,
            child: child,
          )
        : child;
  }
}
