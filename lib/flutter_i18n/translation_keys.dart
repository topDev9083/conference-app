import 'package:flutter/cupertino.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_translate_annotations/flutter_translate_annotations.dart';

part 'translation_keys.g.dart';

@TranslateKeysOptions(
  path: 'assets/flutter_i18n',
)
// ignore: unused_element
class _$TranslationKeys {}

String? translate(
  final BuildContext context,
  final String? key, {
  final String? fallbackKey,
  final Map<String, String>? translationParams,
  final int? pluralValue,
}) {
  if (key == null) {
    return null;
  }
  if (pluralValue != null) {
    return FlutterI18n.plural(
      context,
      key.substring(0, key.length - 2),
      pluralValue,
    );
  }
  return FlutterI18n.translate(
    context,
    key,
    fallbackKey: fallbackKey,
    translationParams: translationParams,
  );
}
