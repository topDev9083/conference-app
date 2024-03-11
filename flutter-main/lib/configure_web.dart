import 'package:flutter/foundation.dart';

// ignore: depend_on_referenced_packages
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

void configureApp() {
  if (kDebugMode) {
    setUrlStrategy(const HashUrlStrategy());
  } else {
    setUrlStrategy(PathUrlStrategy());
  }
}
