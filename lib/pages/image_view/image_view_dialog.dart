import 'package:flutter/material.dart';

import '../../widgets/close_icon.dart';
import '../../widgets/image.dart';

class ImageViewDialog extends StatelessWidget {
  final String? image;

  const ImageViewDialog._({
    this.image,
  });

  static Future<void> show(
    final BuildContext context, {
    final String? image,
  }) {
    return showDialog(
      context: context,
      builder: (final _) => ImageViewDialog._(
        image: image,
      ),
    );
  }

  @override
  Widget build(final BuildContext context) {
    return Dialog(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill(
            child: Align(
              alignment: AlignmentDirectional.topEnd,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CloseIcon(
                  onTap: Navigator.of(context).pop,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 50,
              left: 8,
              right: 8,
              bottom: 8,
            ),
            child: WCImage(
              image: image,
            ),
          ),
        ],
      ),
    );
  }
}
