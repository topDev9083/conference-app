import 'package:flutter/material.dart';

import 'ink_well.dart';

class SheetButton extends StatelessWidget {
  final Widget button;
  final WidgetBuilder dropdown;
  final double? dropDownWidth;
  final double? dropDownHeight;
  final double offset;
  final double? inkWellBorderRadius;
  final bool fromEnd;
  final bool showButtonRipple;
  final bool enabled;

  const SheetButton({
    required this.button,
    required this.dropdown,
    this.dropDownWidth,
    this.dropDownHeight,
    this.offset = 0,
    this.inkWellBorderRadius,
    this.fromEnd = false,
    this.showButtonRipple = true,
    this.enabled = true,
  });

  @override
  Widget build(final BuildContext context) {
    return Stack(
      children: [
        button,
        Positioned.fill(
          child: WCInkWell(
            showInkWellRipple: showButtonRipple,
            borderRadius: inkWellBorderRadius == null
                ? null
                : BorderRadius.circular(inkWellBorderRadius!),
            onTap: enabled
                ? () {
                    FocusScope.of(context).unfocus();
                    _openSheet(context);
                  }
                : null,
          ),
        ),
      ],
    );
  }

  void _openSheet(final BuildContext context) {
    final navigator = Navigator.of(context, rootNavigator: true);
    final RenderBox button = context.findRenderObject()! as RenderBox;
    final RenderBox overlay =
        navigator.overlay!.context.findRenderObject()! as RenderBox;
    final offset = Offset(0, this.offset);
    final position = RelativeRect.fromRect(
      Rect.fromPoints(
        button.localToGlobal(offset, ancestor: overlay),
        button.localToGlobal(
          button.size.bottomRight(Offset.zero) + offset,
          ancestor: overlay,
        ),
      ),
      Offset.zero & overlay.size,
    );
    double? leftPosition;
    double? rightPosition;
    final width = dropDownWidth ?? button.size.width;
    if (fromEnd) {
      rightPosition = position.right;
    } else {
      if (position.left + width > MediaQuery.of(context).size.width) {
        rightPosition = 0;
      } else {
        leftPosition = position.left;
      }
    }
    var positionTop = position.top +
        button.size.height +
        this.offset -
        MediaQuery.of(navigator.context).viewPadding.top;
    if (dropDownHeight != null) {
      if (positionTop + this.offset + dropDownHeight! >
          MediaQuery.of(navigator.context).size.height) {
        positionTop = positionTop -
            dropDownHeight! -
            (this.offset * 2) -
            8 -
            button.size.height;
      }
    }
    final child = Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              onTap: navigator.pop,
            ),
          ),
          PositionedDirectional(
            top: positionTop,
            start: leftPosition,
            end: rightPosition,
            child: SizedBox(
              width: width,
              height: dropDownHeight,
              child: dropdown(navigator.context),
            ),
          ),
        ],
      ),
    );
    navigator.push(
      DialogRoute(
        barrierColor: Colors.transparent,
        context: context,
        builder: (final _) => child,
      ),
    );
  }
}
