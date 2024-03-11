import 'dart:io';

import 'package:path/path.dart';

extension FileExtension on File {
  bool get isImage {
    final name = basename(path);
    return name.endsWith('.jpg') ||
        name.endsWith('.png') ||
        name.endsWith('.jpeg');
  }
}
