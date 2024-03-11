import 'package:intl/intl.dart';

extension StringExtension on String {
  String formatDateTime(final String format) =>
      DateFormat(format).format(DateTime.parse(this).toLocal());
}
