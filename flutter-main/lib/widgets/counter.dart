import 'package:flutter/material.dart';

import '../core/colors.dart';

class Counter extends StatelessWidget {
  final int count;

  const Counter({
    this.count = 0,
  });

  @override
  Widget build(final BuildContext context) {
    return SizedBox(
      width: 25,
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(
          decoration: const BoxDecoration(
            color: WCColors.orange_ff,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              count < 100 ? '$count' : '99+',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 11,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
