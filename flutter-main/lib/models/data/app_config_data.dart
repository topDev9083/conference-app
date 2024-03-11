import 'dart:ui';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'app_config_data.g.dart';

abstract class AppConfigData
    implements Built<AppConfigData, AppConfigDataBuilder> {
  factory AppConfigData([
    final void Function(AppConfigDataBuilder) updates,
  ]) = _$AppConfigData;

  AppConfigData._();

  static Serializer<AppConfigData> get serializer => _$appConfigDataSerializer;

  @BuiltValueHook(initializeBuilder: true)
  static void _initialize(final AppConfigDataBuilder b) => b;

  Color get splashBackgroundColor;

  Color get primaryColor;

  Color get navigationDrawerColor;

  String? get splashLogo;

  String? get sponsorLogo;

  String? get eventLogo;

  String? get coverImage;
}
