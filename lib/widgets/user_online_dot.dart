import 'package:flutter/material.dart';

import '../core/colors.dart';

class UserOnlineDot extends StatelessWidget {
  final bool isOnline;

  const UserOnlineDot({
    required this.isOnline,
  });

  @override
  Widget build(final BuildContext context) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isOnline ? WCColors.green_29 : WCColors.grey_b7,
      ),
    );
  }
}
