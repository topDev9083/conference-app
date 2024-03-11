import 'package:flutter/material.dart';

import 'elevated_button.dart';

class ConnectionInformation extends StatelessWidget {
  final String? error;
  final VoidCallback? onRetry;

  const ConnectionInformation({
    this.error,
    required this.onRetry,
  });

  @override
  Widget build(final BuildContext context) {
    return error == null
        ? const CircularProgressIndicator()
        : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(error!),
              const SizedBox(height: 6),
              WCElevatedButton(
                'RETRY',
                onTap: onRetry,
              ),
            ],
          );
  }
}
