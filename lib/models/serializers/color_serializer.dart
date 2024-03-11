import 'dart:ui' show Color;

import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';

import '../../utils/color_utils.dart';

class ColorSerializer implements PrimitiveSerializer<Color> {
  @override
  Iterable<Type> get types => BuiltList<Type>([Color]);

  @override
  String get wireName => 'Color';

  @override
  Object serialize(
    final Serializers serializers,
    final Color color, {
    final FullType specifiedType = FullType.unspecified,
  }) {
    return ColorUtils.toHex(color);
  }

  @override
  Color deserialize(
    final Serializers serializers,
    final Object serialized, {
    final FullType specifiedType = FullType.unspecified,
  }) {
    if (serialized is int) {
      return Color(serialized);
    } else if (serialized is String) {
      try {
        return ColorUtils.fromHex(serialized);
      } catch (e) {
        throw ArgumentError('Invalid color $serialized');
      }
    } else {
      throw ArgumentError('Invalid type for color: ${serialized.runtimeType}');
    }
  }
}
