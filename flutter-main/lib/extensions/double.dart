extension DoubleExtension on double {
  double toDoubleAsFixed(final int fractionDigits) {
    return double.parse(toStringAsFixed(fractionDigits));
  }
}
