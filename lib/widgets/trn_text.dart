import 'package:flutter/material.dart';

import '../flutter_i18n/translation_keys.dart';

class TrnText extends StatelessWidget {
  final String dataKey;
  final TextStyle? style;
  final TextAlign? textAlign;

  const TrnText(
    this.dataKey, {
    this.style,
    this.textAlign,
  });

  @override
  Widget build(final BuildContext context) {
    return Text(
      translate(context, dataKey)!,
      style: style,
      textAlign: textAlign,
    );
  }
}
