import 'dart:io';

import 'package:ansicolor/ansicolor.dart';
import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';

class LoggingUtils {
  static const _ignoreLoggerNames = [
    'socket_io_client:engine.Socket',
    'socket_io_client:Manager',
    'socket_io_client:Socket',
    'socket_io:parser.Encoder',
    'flutter_i18n',
  ];

  static void initialize() {
    ansiColorDisabled = !kIsWeb && Platform.isIOS;
    Logger.root.level = Level.OFF;
    assert(
      () {
        Logger.root.level = Level.ALL;
        return true;
      }(),
    );
    Logger.root.onRecord.listen((final record) {
      AnsiPen? pen;
      if (record.level == Level.SEVERE) {
        pen = AnsiPen()..red();
      } else if (record.level == Level.WARNING) {
        pen = AnsiPen()..yellow();
      } else if (record.level == Level.INFO) {
        pen = AnsiPen()..blue();
      } else if (record.level == Level.FINE) {
        pen = AnsiPen()..green();
      } else if (record.level == Level.OFF) {
        pen = null;
      } else {
        pen = AnsiPen()..gray();
      }
      if (pen != null && !_ignoreLoggerNames.contains(record.loggerName)) {
        // ignore: avoid_print
        print(pen('${record.loggerName}: ${record.message}'));
      }
    });
  }
}
