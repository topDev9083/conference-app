import 'package:flutter/material.dart';

import '../core/colors.dart';

class DropdownContainer extends StatelessWidget {
  final Widget? child;
  final double? height;
  final double? borderRadius;

  const DropdownContainer({
    this.height,
    this.borderRadius,
    this.child,
  });

  @override
  Widget build(final BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            borderRadius == null ? null : BorderRadius.circular(borderRadius!),
        boxShadow: const [
          BoxShadow(
            color: WCColors.grey_e0,
            offset: Offset(1.1, 7.9),
            blurRadius: 131,
          ),
        ],
      ),
      child: child,
    );
  }
}
