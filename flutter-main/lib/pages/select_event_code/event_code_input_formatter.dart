import 'package:flutter/services.dart';

class EventCodeInputFormatter extends TextInputFormatter {
  static const _REGEX = '^[a-zA-Z0-9_-]+\$';

  @override
  TextEditingValue formatEditUpdate(final TextEditingValue oldValue,
      final TextEditingValue newValue,) {
    if (newValue.text.isEmpty) {
      return newValue;
    }
    final regex = RegExp(_REGEX);
    final hasMatch = regex.hasMatch(newValue.text);
    if (hasMatch) {
      return newValue;
    } else {
      return oldValue;
    }
  }
}
