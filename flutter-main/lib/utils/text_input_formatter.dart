import 'package:flutter/services.dart';

class NumbersTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    final TextEditingValue oldValue,
    final TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue;
    }
    try {
      double.parse(newValue.text);
      return newValue;
    } catch (_) {
      return oldValue;
    }
  }
}
