import 'package:flutter/material.dart';

import '../flutter_i18n/translation_keys.dart';

class PasswordTextFormField extends StatelessWidget {
  final String? hintKey;
  final String? labelKey;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onFieldSubmitted;
  final bool? enabled;
  final String? errorKey;
  final TextInputAction? textInputAction;

  const PasswordTextFormField({
    this.hintKey,
    this.labelKey,
    this.validator,
    this.onChanged,
    this.onFieldSubmitted,
    this.enabled,
    this.errorKey,
    this.textInputAction,
  });

  @override
  Widget build(final BuildContext context) {
    return TextFormField(
      textInputAction: textInputAction,
      obscureText: true,
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: TextInputType.visiblePassword,
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
      enabled: enabled,
      decoration: InputDecoration(
        hintText: translate(context, hintKey),
        labelText: translate(context, labelKey),
        errorText: translate(context, errorKey),
      ),
      autofillHints: const [
        AutofillHints.password,
      ],
    );
  }
}

class EmailTextFormField extends StatelessWidget {
  final String? hintKey;
  final String? labelKey;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onFieldSubmitted;
  final bool? enabled;
  final String? errorKey;
  final TextInputAction? textInputAction;

  const EmailTextFormField({
    this.hintKey,
    this.labelKey,
    this.validator,
    this.onChanged,
    this.onFieldSubmitted,
    this.enabled,
    this.errorKey,
    this.textInputAction,
  });

  @override
  Widget build(final BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: translate(context, hintKey),
        labelText: translate(context, labelKey),
        errorText: translate(context, errorKey),
      ),
      enabled: enabled,
      onChanged: onChanged,
      keyboardType: TextInputType.emailAddress,
      textInputAction: textInputAction,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      onFieldSubmitted: onFieldSubmitted,
      autofillHints: const [
        AutofillHints.email,
      ],
    );
  }
}
