import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:share_plus/share_plus.dart';
import 'package:universal_html/html.dart' as html;

class ShareUtils {
  ShareUtils._();

  static void shareCSV(final String csv) async {
    if (kIsWeb) {
      final content = 'data:text/csv;base64,${base64.encode(utf8.encode(csv))}';
      final anchor = html.AnchorElement(
        href: content,
      )
        ..setAttribute('download', 'scanned-attendees.csv')
        ..click();
      anchor.remove();
    } else {
      final cacheDir = await path_provider.getTemporaryDirectory();
      final file = File(path.join(cacheDir.path, 'scanned-attendees.csv'));
      await file.writeAsString(csv);
      await Share.shareXFiles(
        [
          XFile(
            file.path,
            mimeType: 'text/csv',
          ),
        ],
        subject: 'Scanned Attendees',
        sharePositionOrigin: Rect.zero,
      );
    }
  }
}
