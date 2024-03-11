import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../core/colors.dart';
import 'image.dart';

class RoundImage extends StatelessWidget {
  final String? imageUrl;
  final PlatformFile? imageFile;
  final double? width;
  final double? height;
  final double? borderRadius;
  final BoxFit? fit;

  const RoundImage({
    this.imageUrl,
    this.imageFile,
    this.width,
    this.height,
    this.borderRadius,
    this.fit,
  }) : assert(imageUrl != null || imageFile != null);

  @override
  Widget build(final BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius ?? 4),
      child: SizedBox(
        width: width,
        height: height,
        child: () {
          if (imageFile != null) {
            if (kIsWeb) {
              return Image.memory(
                imageFile!.bytes!,
                fit: fit,
              );
            } else {
              return Image.file(
                File(imageFile!.path!),
                fit: fit,
              );
            }
          } else if (imageUrl != null) {
            return WCImage(
              width: double.infinity,
              height: double.infinity,
              image: imageUrl!,
              fit: fit,
              placeholder: Container(
                color: WCColors.grey_d9,
              ),
            );
          }
          return const SizedBox();
        }(),
      ),
    );
  }
}
