import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class PContainer extends StatelessWidget {
  final Widget? child;

  const PContainer({
    this.child,
  });

  @override
  Widget build(final BuildContext context) {
    return Container(
      padding: getValueForScreenType(
        context: context,
        mobile: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        tablet: const EdgeInsets.symmetric(
          horizontal: 52,
          vertical: 23,
        ),
      ),
      child: child,
    );
  }
}

class PWrappersConstants {
  static double getVGap(final BuildContext context) => getValueForScreenType(
        context: context,
        mobile: 35,
      );

  static double getHGap(final BuildContext context) => getValueForScreenType(
        context: context,
        mobile: 23,
      );
}
