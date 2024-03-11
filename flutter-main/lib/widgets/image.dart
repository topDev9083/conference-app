import 'dart:io';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class WCImage extends StatelessWidget {
  final String? image;
  final Uint8List? bytes;
  final double? width;
  final double? height;
  final Color? color;
  final bool isIcon;
  final Widget? placeholder;
  final BoxFit? fit;

  const WCImage({
    this.image,
    this.bytes,
    this.width,
    this.height,
    this.color,
    this.isIcon = false,
    this.placeholder,
    this.fit,
  }) : assert(image != null || bytes != null);

  @override
  Widget build(final BuildContext context) {
    final iconTheme = IconTheme.of(context);
    final mColor = color ?? (isIcon ? iconTheme.color : null);
    final mWidth = width ?? (isIcon ? iconTheme.size : null);
    final mHeight = height ?? (isIcon ? iconTheme.size : null);
    Widget child;
    if (bytes != null) {
      child = Image.memory(
        bytes!,
        fit: fit,
      );
    } else if (image!.startsWith('https://') ||
        image!.startsWith('http://') ||
        image!.startsWith('blob:http://')) {
      child = CachedNetworkImage(
        imageUrl: image!,
        fit: fit,
        placeholder: (final context, final _) =>
            placeholder ?? const SizedBox.shrink(),
      );
    } else if (image!.startsWith('/')) {
      child = Image.file(
        File(image!),
        fit: fit,
      );
    } else {
      child = Image.asset(
        'assets/images/$image',
        color: mColor,
        fit: fit,
      );
    }
    if (context.findAncestorWidgetOfExactType<TextFormField>() != null) {
      child = Center(
        child: child,
      );
    }
    return SizedBox(
      width: mWidth,
      height: mHeight,
      child: child,
    );
  }
}
