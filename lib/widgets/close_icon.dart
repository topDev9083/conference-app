import 'package:flutter/material.dart';

import '../utils/color_utils.dart';
import 'ink_well.dart';

class CloseIcon extends StatelessWidget {
  final VoidCallback? onTap;
  final Color? bgColor;

  const CloseIcon({
    this.onTap,
    this.bgColor,
  });

  @override
  Widget build(final BuildContext context) {
    return Container(
      width: 33,
      height: 33,
      decoration: BoxDecoration(
        color: bgColor ??
            ColorUtils.lighten(
              Theme.of(context).primaryColor,
              0.9,
            ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: WCInkWell(
        borderRadius: BorderRadius.circular(5),
        onTap: onTap,
        child: const Center(
          child: Icon(Icons.close_rounded),
        ),
      ),
    );
  }
}
