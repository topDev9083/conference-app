import 'package:flutter/material.dart';

class HoverText extends StatefulWidget {
  final String data;
  final TextStyle? style;
  final bool active;

  const HoverText(
    this.data, {
    this.style,
    this.active = true,
  });

  @override
  _HoverTextState createState() => _HoverTextState();
}

class _HoverTextState extends State<HoverText> {
  bool isUnderline = false;

  @override
  Widget build(final BuildContext context) {
    return MouseRegion(
      cursor: widget.active ? SystemMouseCursors.click : MouseCursor.defer,
      onEnter: (final _) => setState(() => isUnderline = true),
      onExit: (final _) => setState(() => isUnderline = false),
      child: Text(
        widget.data,
        style: widget.style?.copyWith(
          decoration:
              isUnderline && widget.active ? TextDecoration.underline : null,
        ),
      ),
    );
  }
}
