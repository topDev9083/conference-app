import 'package:flutter/material.dart';

import '../flutter_i18n/translation_keys.dart';

class SearchTextFormField extends StatelessWidget {
  final String? initialValue;
  final ValueChanged<String>? onChanged;

  const SearchTextFormField({
    this.initialValue,
    this.onChanged,
  });

  @override
  Widget build(final BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: translate(context, TranslationKeys.General_Search),
        prefixIcon: const Icon(Icons.search),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 13,
        ),
      ),
    );
  }
}
