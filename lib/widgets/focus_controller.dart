import 'package:after_layout/after_layout.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../utils/responsive_utils.dart';

class FocusController extends StatefulWidget {
  final Widget Function(FocusNode) builder;

  const FocusController({
    required this.builder,
  });

  @override
  _FocusControllerState createState() => _FocusControllerState();
}

class _FocusControllerState extends State<FocusController>
    with AfterLayoutMixin {
  final focusNode = FocusNode();

  @override
  Widget build(final BuildContext context) {
    return widget.builder(focusNode);
  }

  @override
  void afterFirstLayout(final BuildContext context) {
    if (ScreenType.of(context).isMobile || !kIsWeb) {
      return;
    }
    requestFocus();
  }

  Future<void> requestFocus() async {
    final focusScope = FocusScope.of(context);
    await Future.delayed(const Duration(milliseconds: 500));
    if (focusNode.canRequestFocus) {
      focusScope.requestFocus(focusNode);
    }
  }
}
