import 'package:flutter/material.dart';

import 'responsive.dart';

class StaticGrid extends StatelessWidget {
  final List<Widget> children;
  final int columns;
  final double? spacing;
  final double? runSpacing;
  final bool expand;
  final CrossAxisAlignment runCrossAxisAlignment;

  const StaticGrid({
    required this.children,
    this.columns = 1,
    this.spacing,
    this.runSpacing,
    this.expand = true,
    this.runCrossAxisAlignment = CrossAxisAlignment.center,
  });

  @override
  Widget build(final BuildContext context) {
    return Column(
      children: [
        for (int i = 0; i < (children.length / columns).ceil(); i++) ...[
          Builder(
            builder: (final _) {
              final start = i * columns;
              final end = start + columns;
              return Padding(
                padding: EdgeInsets.only(
                  top: i != 0 ? runSpacing ?? 0 : 0,
                ),
                child: Row(
                  crossAxisAlignment: runCrossAxisAlignment,
                  children: [
                    for (int j = start; j < end; j++) ...[
                      WCExpanded(
                        expand: expand,
                        child: Padding(
                          padding: EdgeInsetsDirectional.only(
                            start: j != start ? (spacing ?? 0) / 2 : 0,
                            end: j != end - 1 ? (spacing ?? 0) / 2 : 0,
                          ),
                          child: j < children.length
                              ? children[j]
                              : const SizedBox(),
                        ),
                      ),
                    ],
                  ],
                ),
              );
            },
          ),
        ],
      ],
    );
  }
}
