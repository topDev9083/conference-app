import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../utils/color_utils.dart';

class FullScreenDrawer extends StatelessWidget {
  final Widget? child;
  final double width;
  final double margin;

  const FullScreenDrawer({
    this.child,
    this.width = 780,
    this.margin = 80,
  });

  @override
  Widget build(final BuildContext context) {
    return ResponsiveBuilder(
      builder: (final _, final info) => Container(
        width: info.screenSize.width > width + margin
            ? width
            : info.screenSize.width - margin,
        color: ColorUtils.lighten(
          Theme.of(context).primaryColor,
          0.95,
        ),
        child: Scaffold(
          body: SafeArea(
            child: child ?? const SizedBox(),
          ),
        ),
      ),
    );
  }
}
