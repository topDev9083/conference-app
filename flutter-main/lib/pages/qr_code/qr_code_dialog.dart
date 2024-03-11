import 'package:flutter/material.dart';

import '../../core/constants.dart';
import '../../widgets/close_icon.dart';
import '../../widgets/qr_code.dart';

class QrCodeDialog extends StatelessWidget {
  static Future<void> show(final BuildContext context) {
    return showDialog(
      context: context,
      builder: (final _) => const Dialog(
        child: QrCodeDialog._(),
      ),
    );
  }

  const QrCodeDialog._();

  @override
  Widget build(final BuildContext context) {
    return SizedBox(
      width: DIALOG_WIDTH,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 16),
          Align(
            alignment: AlignmentDirectional.centerEnd,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: CloseIcon(
                onTap: () => Navigator.pop(context),
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: QrCode(),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
