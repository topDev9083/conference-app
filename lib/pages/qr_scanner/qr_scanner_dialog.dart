import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../core/constants.dart';
import '../../widgets/close_icon.dart';

class QrScannerDialog extends StatelessWidget {
  const QrScannerDialog._();

  static Future<String?> show(final BuildContext context) {
    return showDialog<String>(
      context: context,
      builder: (final _) => const Center(
        child: QrScannerDialog._(),
      ),
    );
  }

  @override
  Widget build(final BuildContext context) {
    return Container(
      width: DIALOG_WIDTH,
      color: Colors.white,
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
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: SizedBox(
              height: 400,
              child: MobileScanner(
                onDetect: (final barcodes) => _onQRCodeDetected(context, barcodes.barcodes.first),
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  void _onQRCodeDetected(final BuildContext context, final Barcode barcode) {
    Navigator.pop(context, barcode.rawValue);
  }
}
