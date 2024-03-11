import 'package:flutter/material.dart';

import '../core/colors.dart';
import 'responsive.dart';

class BorderedRow extends StatelessWidget {
  final List<Widget> children;
  final bool isExpand;

  const BorderedRow({
    this.children = const [],
    this.isExpand = false,
  });

  @override
  Widget build(final BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: WCColors.grey_d9,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(3),
      ),
      child: Row(
        children: [
          for (var i = 0; i < children.length; i++) ...[
            WCExpanded(
              expand: isExpand,
              child: Container(
                decoration: BoxDecoration(
                  border: BorderDirectional(
                    start: BorderSide(
                      width: i == 0 ? 0 : 1,
                      color: WCColors.grey_d9,
                    ),
                    end: BorderSide(
                      width: i == children.length - 1 ? 0 : 1,
                      color: WCColors.grey_d9,
                    ),
                  ),
                ),
                child: children[i],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
