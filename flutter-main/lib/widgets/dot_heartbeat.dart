import 'package:flutter/material.dart';

import '../core/colors.dart';

class DotHeartbeat extends StatelessWidget {
  const DotHeartbeat();

  @override
  Widget build(final BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 6,
          height: 6,
          decoration: const BoxDecoration(
            color: WCColors.green_29,
            shape: BoxShape.circle,
          ),
        ),
        const _Ring(),
      ],
    );
  }
}

class _Ring extends StatefulWidget {
  const _Ring();

  @override
  __RingState createState() => __RingState();
}

class __RingState extends State<_Ring> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1100),
      vsync: this,
    );
    _controller.repeat();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (final _, final child) => Transform.scale(
        scale: Tween<double>(
          begin: 1,
          end: 2.5,
        ).evaluate(_controller),
        child: Opacity(
          opacity: Tween<double>(
            begin: 0.8,
            end: 0,
          ).evaluate(_controller),
          child: child,
        ),
      ),
      child: Container(
        width: 6,
        height: 6,
        decoration: BoxDecoration(
          color: Colors.transparent,
          shape: BoxShape.circle,
          border: Border.all(
            color: WCColors.green_29,
          ),
        ),
      ),
    );
  }
}
