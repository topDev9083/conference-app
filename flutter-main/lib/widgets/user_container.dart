import 'package:flutter/material.dart';

import '../core/colors.dart';
import 'ink_well.dart';

class UserContainer extends StatelessWidget {
  final Widget? child;
  final VoidCallback? onTap;
  final bool showShadow;
  final EdgeInsetsGeometry? padding;

  const UserContainer({
    this.child,
    this.onTap,
    this.showShadow = false,
    this.padding,
  });

  @override
  Widget build(final BuildContext context) {
    final ch = Padding(
      padding: padding ??
          const EdgeInsets.only(
            left: 10,
            right: 10,
            top: 10,
            bottom: 25,
          ),
      child: child,
    );

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: WCColors.grey_e7,
        ),
        borderRadius: BorderRadius.circular(5),
        boxShadow: showShadow
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.03),
                  offset: const Offset(4.6, 32.7),
                  blurRadius: 84,
                ),
              ]
            : null,
      ),
      child: onTap == null
          ? ch
          : WCInkWell(
              borderRadius: BorderRadius.circular(5),
              hoverColor: Theme.of(context).primaryColor.withOpacity(0.05),
              onTap: onTap,
              child: ch,
            ),
    );
  }
}
