import 'package:flutter/material.dart';

import '../core/colors.dart';
import 'ink_well.dart';

class WCCheckboxTile extends StatelessWidget {
  final String title;
  final ValueChanged<bool> onChanged;
  final bool value;

  const WCCheckboxTile({
    required this.title,
    required this.onChanged,
    required this.value,
  });

  @override
  Widget build(final BuildContext context) {
    return WCInkWell(
      onTap: () => onChanged(!value),
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 10,
      ),
      child: Row(
        children: [
          Checkbox(
            value: value,
            onChanged: (final value) => onChanged(value == true),
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              title,
              style: TextStyle(
                color: WCColors.black_09.withOpacity(0.73),
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
