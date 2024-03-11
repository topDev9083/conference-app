import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class FragmentPadding extends StatelessWidget {
  final Widget child;

  const FragmentPadding({
    required this.child,
  });

  @override
  Widget build(final BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: getValueForScreenType(
          context: context,
          mobile: 16,
          tablet: 26,
        ),
      ),
      child: child,
    );
  }
}
