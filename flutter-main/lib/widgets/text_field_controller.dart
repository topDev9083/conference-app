import 'package:flutter/material.dart';

class TextFieldController extends StatefulWidget {
  final Widget Function(TextEditingController) builder;

  const TextFieldController({
    required this.builder,
  });

  @override
  _TextFieldControllerState createState() => _TextFieldControllerState();
}

class _TextFieldControllerState extends State<TextFieldController> {
  final controller = TextEditingController();

  @override
  Widget build(final BuildContext context) {
    return widget.builder(controller);
  }
}
